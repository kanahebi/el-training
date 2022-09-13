import React, { useState, useEffect } from 'react'
import { useQuery, useMutation, gql } from "@apollo/client";
import { Link, useParams, useNavigate } from "react-router-dom";
import { Modal } from "../components/Modal";
import { GET_TASK, GET_TASKS } from '../graphql/query'
import { DELETE_TASK } from '../graphql/mutation'

type RouterParams = {
  id: string;
};

export const TaskView = () => {
  const navigate = useNavigate();
  const [showModal, setShowModal] = useState(false);
  const [deleteConfirm, setDeleteConfirm] = useState(false);
  const { id } = useParams<RouterParams>();
  const { loading, error, data } = useQuery(GET_TASK, {
    variables: { id: id },
  });
  const [deleteTask, { loading: mutationLoading, error: mutationError }] = useMutation(DELETE_TASK,
    {
      update(cache, { data }) {
        const existingTasks: any = cache.readQuery({ query: GET_TASKS });
        if(existingTasks) {
          const newTasks = existingTasks!.tasks.filter((t:any) => (t.id !== data.deleteTask.task.id));
          cache.writeQuery({
            query: GET_TASKS,
            data: {
              tasks: newTasks
            }
          });
        }
        navigate(`/tasks`, { state: { alert: '削除しました。' }},);
      }
    });

  const ShowModal = () => {
    setShowModal(true);
  };

  useEffect(() => {
    if(deleteConfirm) {
      deleteTask({
        variables: {
          id: id,
        }
      });
    }
  }, [deleteConfirm]);

  if (loading) return (<div>'ロード中....'</div>);
  if (error) return (<div>`Error ${error.message}`</div>);

  return (
    <>
      <div className='main-content'>
        <div className="flex flex-col justify-center">
          <Modal showFlag={showModal} setShowModal={setShowModal} setDeleteConfirm={setDeleteConfirm} content="本当に削除しますか？" />
          <div className="mx-auto mt-5">
            <Link to='/tasks' type="button" className="inline-block
              bg-white
              px-6
              py-2
              border-2
              border-blue-400
              text-blue-400
              font-medium
              text-xs
              leading-tight
              uppercase
              rounded
              hover:bg-black
              hover:bg-opacity-5
              focus:outline-none
              focus:ring-0
              transition
              duration-150
              ease-in-out"
            >一覧へ戻る</Link>
          </div>
          <div className="basis-40 m-5">
            <div className="block p-6 rounded-lg shadow-lg bg-white max-w-sm mx-auto">
              <h5 className="text-gray-900 text-xl leading-tight font-medium mb-2">{ data.task.name }</h5>
              <p className="text-gray-700 text-base mb-4">{ data.task.description }</p>
              <Link to={`/tasks/${id}/edit`} className="px-6
                mx-5
                py-2.5
                bg-blue-600
                text-white
                font-medium
                text-xs
                leading-tight
                uppercase
                rounded
                shadow-md
                hover:bg-blue-700 hover:shadow-lg
                focus:bg-blue-700 focus:shadow-lg focus:outline-none focus:ring-0
                active:bg-blue-800 active:shadow-lg
                transition
                duration-150
                ease-in-out
                ml-1">編集</Link>
              <button type="button" className="px-6
                py-2.5
                bg-red-600
                text-white
                font-medium
                text-xs
                leading-tight
                uppercase
                rounded
                shadow-md
                hover:bg-red-700 hover:shadow-lg
                focus:bg-red-700 focus:shadow-lg focus:outline-none focus:ring-0
                active:bg-red-800 active:shadow-lg
                transition
                duration-150
                ease-in-out" onClick={ShowModal}>削除</button>
            </div>
          </div>
        </div>
      </div>
    </>
  )
};

import React, { useState, useEffect } from 'react'
import { useQuery, useMutation, gql } from "@apollo/client";
import { Link } from "react-router-dom";
import { Modal } from "../components/Modal";
import { Alert } from "../components/Alert";

const GET_TASKS = gql`
  query GetTasks {
    tasks {
      id
      name
      description
    }
  }
`;

const DELETE_TASK = gql`
  mutation DeleteTask($id: ID!) {
    deleteTask(
      input: {
        id: $id
      }
    ){
      task {
        id
        name
        description
      }
    }
  }
`;

export const Tasks = () => {
  const [showAlert, setShowAlert] = useState(false);
  const [showModal, setShowModal] = useState(false);
  const [deleteConfirm, setDeleteConfirm] = useState(false);
  const [deleteID, setDeleteID] = useState('');
  const {loading, error, data} = useQuery(GET_TASKS);
  const [deleteTask, { loading: mutationLoading, error: mutationError }] = useMutation(DELETE_TASK,
    {
      update(cache, { data }) {
        const existingTasks: any = cache.readQuery({ query: GET_TASKS });
        const newTasks = existingTasks!.tasks.filter((t:any) => (t.id !== data.deleteTask.task.id));
        cache.writeQuery({
          query: GET_TASKS,
          data: {
            tasks: newTasks
          }
        });
       }
    });

  const ShowModal = () => {
    setShowModal(true);
  };

  useEffect(() => {
    if(deleteConfirm) {
      deleteTask({
        variables: {
          id: deleteID,
        }
      });
      setShowAlert(true);
    }
  }, [deleteConfirm]);

  if (loading) return (<div>'ロード中....'</div>);
  if (error) return (<div>`Error ${error.message}`</div>);
  if (mutationError) return (<div>`Error ${mutationError.message}`</div>);

  return (
    <div>
      <Alert showFlag={showAlert} setShowAlert={setShowAlert} content="削除しました。" />
      {data.tasks.length ? (data.tasks.map(task => (
        <div key={task.id}>
          <Link to={`/tasks/${task.id}`}>
            <div>
              <h1>{task.name}</h1>
              <div>{task.description}</div>
            </div>
          </Link>
          <button className='bg-red-600 hover:bg-red-700 text-white rounded px-4 py-2'
            onClick={() =>
              {
                setDeleteID(task.id);
                ShowModal();
              }
            }
          >削除</button>
        </div>
      ))) : (
        <div>タスクはありません。</div>
      )}
      <Modal showFlag={showModal} setShowModal={setShowModal} setDeleteConfirm={setDeleteConfirm} content="本当に削除しますか？" />
    </div>
  )
};

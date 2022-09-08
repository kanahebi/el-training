import React from 'react';
import { gql, useQuery, useMutation } from "@apollo/client";
import { useParams, useNavigate, Link } from 'react-router-dom'
import { GET_TASK } from '../graphql/query'
import { UPDATE_TASK } from '../graphql/mutation'

type RouterParams = {
  id: string;
};

export const EditTask = () => {
  const {id} = useParams<RouterParams>();
  const navigate = useNavigate();
  const {loading, error, data} = useQuery(GET_TASK, {
    variables: { id: id },
  });
  const [updateTask, { loading: mutationLoading, error: mutationError }] = useMutation(UPDATE_TASK, {
    onCompleted(data) {
      navigate(`/tasks/${id}`);
    }
  })

  let inputName: HTMLInputElement;
  let inputDescription: HTMLTextAreaElement;

  if (loading) return (<div>'ロード中....'</div>);
  if (error) return (<div>`Error ${error.message}`</div>);

  if (mutationLoading) return (<div>'データ送信中...'</div>);
  if (mutationError) return (<div>`Error {mutationError.message}`</div>);

  return (
    <>
      <div className='main-content'>
        <div className="flex flex-col justify-center">
          <div className="mx-auto mt-5">
            <Link to={`/tasks/${id}`} type="button" className="inline-block
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
            >詳細へ戻る</Link>
          </div>
          <div className="mx-auto mt-5">
            <div className="block p-6 rounded-lg shadow-lg bg-white max-w-md">
              <form
                onSubmit={e => {
                  e.preventDefault();
                  updateTask({
                    variables: {
                      id: id,
                      name: inputName.value,
                      description: inputDescription.value,
                    }
                  });
                  inputName.value = "";
                  inputDescription.value = "";
                }}
              >
                <div className="form-group mb-6">
                  <label className="form-label inline-block mb-2 text-gray-700">タスクの名前</label>
                  <input ref={node => {
                      inputName = node;
                    }}
                    defaultValue={data.task.name}
                    name="name"
                    type="text" className="form-control block
                    w-full
                    px-3
                    py-1.5
                    text-base
                    font-normal
                    text-gray-700
                    bg-white bg-clip-padding
                    border border-solid border-gray-300
                    rounded
                    transition
                    ease-in-out
                    m-0
                    focus:text-gray-700 focus:bg-white focus:border-blue-600 focus:outline-none" />
                </div>
                <div className="form-group mb-6">
                  <label className="form-label inline-block mb-2 text-gray-700">タスクの説明</label>
                  <textarea
                    ref={node => {
                      inputDescription = node;
                    }}
                    defaultValue={data.task.description}
                    name="description"
                    className="
                      form-control
                      block
                      w-full
                      px-3
                      py-1.5
                      text-base
                      font-normal
                      text-gray-700
                      bg-white bg-clip-padding
                      border border-solid border-gray-300
                      rounded
                      transition
                      ease-in-out
                      m-0
                      focus:text-gray-700 focus:bg-white focus:border-blue-600 focus:outline-none
                    "
                    rows={3}
                  ></textarea>
                </div>
                <button type="submit" className="
                  w-full
                  px-6
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
                  ease-in-out">タスクを更新</button>
              </form>
            </div>
          </div>
        </div>
      </div>
    </>
  );
};

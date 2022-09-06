import React from 'react';
import { gql, useMutation } from "@apollo/client";
import { useNavigate, Link } from "react-router-dom";

const CREATE_TASK = gql`
  mutation CreateTask($name: String!, $description: String!) {
    createTask(
      input: {
        name: $name,
        description: $description
      }
    ){
      task {
        id
        name
        description
        createdAt
      }
    }
  }
`;

const GET_TASKS = gql`
  query GetTasks {
    tasks {
      id
      name
      description
      createdAt
    }
  }
`;

export const NewTask = () => {
  const navigate = useNavigate();
  let inputName: HTMLInputElement;
  let inputDescription: HTMLTextAreaElement;
  const [createTask, { loading, error }] = useMutation(CREATE_TASK, {
    update(cache, { data }) {
      const existingTasks: any = cache.readQuery({ query: GET_TASKS });
      if(existingTasks) {
        const newTask = data.createTask.task;
        const newTasks = [...existingTasks?.tasks, newTask].sort(function(first, second){
          if(first.createdAt > second.createdAt) return -1;
          if(first.createdAt < second.createdAt) return 1;
          return 0;
        });
        cache.writeQuery({
          query: GET_TASKS,
          data: { tasks: newTasks }
        });
      }
      navigate(`/tasks/${data['createTask']['task']['id']}`);
    }
  })

  if (loading) return <p>Submitting...</p>;
  if (error) return <p>Submission error! {error.message}</p>;

  return (
    <>
      <div className='main-content'>
        <div className="flex flex-col justify-center">
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
          <div className="mx-auto mt-5">
            <div className="block p-6 rounded-lg shadow-lg bg-white max-w-md">
              <form
                onSubmit={e => {
                  e.preventDefault();
                  createTask({
                    variables: {
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
                  ease-in-out">タスクを追加</button>
              </form>
            </div>
          </div>
        </div>
      </div>
    </>
  );
};

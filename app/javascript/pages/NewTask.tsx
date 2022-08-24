import React from 'react'; 
import { gql, useMutation } from "@apollo/client";
import { useNavigate } from "react-router-dom";

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
      }
    }
  }
`;

export const NewTask = () => {
  const navigate = useNavigate();
  let inputName: HTMLInputElement;
  let inputDescription: HTMLInputElement;
  const [createTask, { loading, error }] = useMutation(CREATE_TASK, {
    onCompleted(data) {
      navigate("/tasks/"+data['createTask']['task']['id']);
    }
  })

  if (loading) return <p>Submitting...</p>;
  if (error) return <p>Submission error! {error.message}</p>;

  return (

    <div>
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
        <div>
          <input
            ref={node => {
              inputName = node;
            }}
            name="name"
          />
          <input
            ref={node => {
              inputDescription = node;
            }}
            name="description"
          />
        </div>
        <button type="submit">タスクを追加</button>
      </form>
    </div>
  );
};

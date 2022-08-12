import React from 'react'; 
import { gql, useMutation } from "@apollo/client";

const CREATE_TASK = gql`
  mutation createTask($name: String!, $description: String!) {
    createTask(
      input: {
        name: $name,
        description: $description
      }
    ){
      result
    }
  }
`;

export const NewTask = () => {
	let inputName: HTMLInputElement;
	let inputDescription: HTMLInputElement;
  const [createTask, { loading, error }] = useMutation(CREATE_TASK)

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
          />
          <input
            ref={node => {
              inputDescription = node;
            }}
          />
        </div>
        <button type="submit">タスクを追加 </button>
      </form>
    </div>
	);
};

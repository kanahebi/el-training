import React from 'react'; 
import { gql, useQuery, useMutation } from "@apollo/client";
import { useParams } from 'react-router-dom'

const GET_TASK = gql`
  query GetTask($id: ID!) {
    task(id: $id) {
      id
      name
      description
    }
  }
`;

const UPDATE_TASK = gql`
  mutation UpdateTask($id: ID!, $name: String!, $description: String!) {
    updateTask(
      input: {
        id: $id
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

type RouterParams = {
  id: string;
};

export const EditTask = () => {
  const {id} = useParams<RouterParams>();
  const {loading, error, data} = useQuery(GET_TASK, {
    variables: { id: id },
  });
  const [updateTask, { loading: mutationLoading, error: mutationError }] = useMutation(UPDATE_TASK)

  let inputName: HTMLInputElement;
  let inputDescription: HTMLInputElement;

  if (loading) return (<div>'ロード中....'</div>);
  if (error) return (<div>`Error ${error.message}`</div>);

  if (mutationLoading) return (<div>'データ送信中...'</div>);
  if (mutationError) return (<div>`Error {mutationError.message}`</div>);

  return (
    <div>
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
        <div>
          <input
            ref={node => {
              inputName = node;
            }}
            defaultValue={data.task.name}
          />
          <input
            ref={node => {
              inputDescription = node;
            }}
            defaultValue={data.task.description}
          />
        </div>
        <button type="submit">タスクを更新</button>
      </form>
    </div>
  );
};

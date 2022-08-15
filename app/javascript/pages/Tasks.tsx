import React from 'react'
import { useQuery, useMutation, gql } from "@apollo/client";
import { Link } from "react-router-dom";

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
  const {loading, error, data} = useQuery(GET_TASKS);
  const [deleteTask, { loading: mutationLoading, error: mutationError }] = useMutation(DELETE_TASK)

  if (loading) return (<div>'ロード中....'</div>);
  if (error) return (<div>`Error ${error.message}`</div>);

  return (
    <div>
      {data.tasks.map(task => (
        <div key={task.id}>
          <Link to={`/tasks/${task.id}`}>
            <div>
              <h1>{task.name}</h1>
              <div>{task.description}</div>
            </div>
          </Link>
          <button
            onClick={() =>
              deleteTask({
                variables: {
                  id: task.id,
                }
              })
            }
          >削除</button>
        </div>
      ))}
    </div>
  )
};

import React from 'react'
import { useQuery, gql } from "@apollo/client";

const GET_TASKS = gql`
  query GetTasks {
    tasks {
      id
      name
      description
    }
  }
`;

export const Tasks = () => {
  const {loading, error, data} = useQuery(GET_TASKS);

  if (loading) return (<div>'ロード中....'</div>);
  if (error) return (<div>`Error ${error.message}`</div>);

  return (
    <div>
      {data.tasks.map(task => (
        <div key={task.id}>
          <h1>{task.name}</h1>
          <div>{task.description}</div>
        </div>
      ))}
    </div>
  )
};

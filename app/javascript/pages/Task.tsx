import React from 'react'
import { useQuery, gql } from "@apollo/client";
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

type RouterParams = {
  id: string;
};

export const Task = () => {
  const {id} = useParams<RouterParams>();
  const {loading, error, data} = useQuery(GET_TASK, {
    variables: { id: id },
  });

  if (loading) return (<div>'ロード中....'</div>);
  if (error) return (<div>`Error ${error.message}`</div>);

  return (
    <div>
      <div key={data.task.id}>
        <h1>タスクの名前: {data.task.name}</h1>
        <div>内容</div>
        <div>{data.task.description}</div>
      </div>
    </div>
  )
};

import { gql } from "@apollo/client";

export const GET_TASK = gql`
  query GetTask($id: ID!) {
    task(id: $id) {
      id
      name
      description
    }
  }
`;

export const GET_TASKS = gql`
  query GetTasks {
    tasks {
      id
      name
      description
    }
  }
`;

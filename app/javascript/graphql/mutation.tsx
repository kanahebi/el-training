import { gql } from "@apollo/client";

export const UPDATE_TASK = gql`
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

export const CREATE_TASK = gql`
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


export const DELETE_TASK = gql`
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

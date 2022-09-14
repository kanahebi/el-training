import { gql } from "@apollo/client";

export const GET_TASK = gql`
  query GetTask($id: ID!) {
    task(id: $id) {
      id
      name
      description
      createdAt
    }
  }
`;

export const GET_TASKS = gql`
  query GetTasks {
    tasks {
      id
      name
      description
      createdAt
    }
  }
`;

export const GET_TASKS_PAGINATE = gql`
  query GetTasksPaginate($page: Int!, $per: Int!) {
    tasksPaginate(page: $page, per: $per) {
      tasks {
        id
        name
        description
        createdAt
      }
      pageInfo {
        totalCount
        limitValue
        totalPages
        currentPage
        nextPage
        prevPage
        isFirstPage
        isLastPage
      }
    }
  }
`;

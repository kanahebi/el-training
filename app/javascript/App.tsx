import React from 'react'
import { BrowserRouter as Router } from 'react-router-dom'
import { AppRoutes } from './AppRoutes'
import {
  ApolloClient,
  InMemoryCache,
  ApolloProvider,
  HttpLink,
  ApolloLink,
} from "@apollo/client";

const httpLink = new HttpLink({ uri: "/graphql" });

const middlewareLink = new ApolloLink((operation, forward) => {
  operation.setContext(({ headers = {} }) => ({
    headers: {
      ...headers,
      "X-CSRF-Token":
        sessionStorage.getItem("csrfToken") ||
        document.querySelector<HTMLMetaElement>('meta[name="csrf-token"]')
          ?.content ||
        null,
    },
  }));

  return forward(operation);
});

const afterwareLink = new ApolloLink((operation, forward) => {
  return forward(operation).map((response) => {
    const context = operation.getContext();
    const headers = context.response.headers;

    if (headers && headers.get("csrf-token")) {
      sessionStorage.setItem("csrfToken", headers.get("csrf-token"));
    }

    return response;
  });
});

const client = new ApolloClient({
  link: ApolloLink.from([middlewareLink, afterwareLink, httpLink]),
  cache: new InMemoryCache(),
});

export const App: React.FC = () => {
  return (
    <ApolloProvider client={client} >
      <Router>
        <AppRoutes />
      </Router>
    </ApolloProvider>
  )
}

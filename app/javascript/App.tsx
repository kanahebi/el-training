import React from 'react'
import { BrowserRouter as Router } from 'react-router-dom'
import { AppRoutes } from './AppRoutes'
import {
  ApolloClient,
  InMemoryCache,
  ApolloProvider
} from "@apollo/client";

const client = new ApolloClient({
  uri: 'http://localhost:3000/graphql',
  credentials: 'include',
  headers: {
    'X-CSRFToken': document.querySelector('meta[name="csrf-token"]').getAttribute('content')
  },
  cache: new InMemoryCache()
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

import React from 'react';
import { Routes, Route } from 'react-router-dom';
import { Login } from './pages/Login';
import { AuthenticatedGuard } from './AuthenticatedGuard';
import { Tasks } from './pages/Tasks';
import { TaskView } from './pages/TaskView';
import { NewTask } from './pages/NewTask';
import { EditTask } from './pages/EditTask';
import { NotFound } from './pages/NotFound';

export const AppRoutes = () => {
  return (
    <>
      <Routes>
        <Route path="/login" element={<Login />} />
        <Route element={<AuthenticatedGuard />}>
          <Route path="/" element={<Tasks />} />
          <Route path="/tasks" element={<Tasks />} />
          <Route path="/tasks/:id" element={<TaskView />} />
          <Route path="/tasks/:id/edit" element={<EditTask />} />
          <Route path="/tasks/new" element={<NewTask />} />
        </Route>
        <Route path="*" element={<NotFound />} />
      </Routes >
    </>
  )
};

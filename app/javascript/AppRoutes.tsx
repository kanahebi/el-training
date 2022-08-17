import React, { FC } from 'react';
import { Routes, Route } from 'react-router-dom';
import { Tasks } from './pages/Tasks';
import { Task } from './pages/Task';
import { NewTask } from './pages/NewTask';
import { EditTask } from './pages/EditTask';

export const AppRoutes = () => {
  return (
    <Routes>
      <Route path="/" element={<Tasks />} />
      <Route path="/tasks" element={<Tasks />} />
      <Route path="/tasks/:id" element={<Task />} />
      <Route path="/tasks/:id/edit" element={<EditTask />} />
      <Route path="/tasks/new" element={<NewTask />} />
    </Routes >
  )
};

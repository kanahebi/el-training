import React, { FC } from 'react';
import { Routes, Route, useLocation } from 'react-router-dom';
import { Tasks } from './pages/Tasks';
import { TaskView } from './pages/TaskView';
import { NewTask } from './pages/NewTask';
import { EditTask } from './pages/EditTask';

interface State {
  background: string;
};

export const AppRoutes = () => {
  return (
    <>
      <Routes>
        <Route path="/" element={<Tasks />} />
        <Route path="/tasks" element={<Tasks />} />
        <Route path="/tasks/:id" element={<TaskView />} />
        <Route path="/tasks/:id/edit" element={<EditTask />} />
        <Route path="/tasks/new" element={<NewTask />} />
      </Routes >
    </>
  )
};

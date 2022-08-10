import React, { FC } from 'react';
import { Routes, Route } from 'react-router-dom';
import { Tasks } from './pages/Tasks';
import { Task } from './pages/Task';

export const AppRoutes = () => {
  return (
    <Routes>
      <Route path="/" element={<Tasks />} />
      <Route path="/tasks" element={<Tasks />} />
      <Route path="/tasks/:id" element={<Task />} />
    </Routes >
  )
};

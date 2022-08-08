import React from 'react'
import { Routes, Route } from 'react-router-dom'
import { Tasks } from './pages/Tasks'

export const AppRoutes = () => {
  return (
    <Routes>
      <Route path="/" element={<Tasks />} />
    </Routes >
  )
}

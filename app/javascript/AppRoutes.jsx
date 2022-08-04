import React from 'react'
import { Routes, Route } from 'react-router-dom'
import { Foo } from './pages/Foo'
import { Bar } from './pages/Bar'

export const AppRoutes = () => {
  return (
    <Routes>
      <Route path="/" component={Foo} />
      <Route path="/spa/foo" element={<Foo />} />
      <Route path="/spa/bar" element={<Bar />} />
    </Routes >
  )
}

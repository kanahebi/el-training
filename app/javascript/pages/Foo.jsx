import React from 'react'
import { Link } from "react-router-dom";

export const Foo = () => {
  return (
    <div>
      <h1>これはfooページです。</h1>
      <div><Link to="/spa/bar">Bar</Link></div>
    </div>
  )
}

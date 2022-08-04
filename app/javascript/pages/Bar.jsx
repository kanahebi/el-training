import React from 'react'
import { Link } from "react-router-dom";

export const Bar = () => {
  return (
    <div>
      <h1>これはbarページです。</h1>
      <div><Link to="/spa/foo">Foo</Link></div>
    </div>
  )
}

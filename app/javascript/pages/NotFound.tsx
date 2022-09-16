import React from 'react';
import { Link } from "react-router-dom";

export const NotFound = () => {
  return (
    <>
      <div className='main-content'>
        <div className="flex flex-col justify-center">
          <div className="mx-auto mt-5">
            <div className="block p-6 rounded-lg shadow-lg bg-white max-w-md text-center">
              <div>どうやら、お探しのページは見つかリませんでした。</div>
              <Link to='/' className="underline">トップへ</Link>
            </div>
          </div>
        </div>
      </div>
    </>
  );
};

import React from 'react';
import { useNavigate } from "react-router-dom";

export const Logout = () => {
  const navigate = useNavigate();

  const ExecLogout = () => {
    sessionStorage.removeItem('authToken');
    navigate('/login');
  };

  return (
    <>
      <div className="flex flex-col justify-center">
        <div className="mx-auto mt-5">
          <button className="inline-block
              bg-white
              px-6
              py-2
              border-2
              border-red-400
              text-red-400
              font-medium
              text-xs
              leading-tight
              uppercase
              rounded
              hover:bg-black
              hover:bg-opacity-5
              focus:outline-none
              focus:ring-0
              transition
              duration-150
              ease-in-out"
            onClick={ExecLogout}>ログアウト</button>
        </div>
      </div>
    </>
  );
};

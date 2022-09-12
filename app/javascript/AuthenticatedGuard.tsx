import React, { ReactNode } from 'react';
import { Navigate, useLocation, Outlet } from 'react-router-dom';
import { Logout } from './components/Logout';

export const AuthenticatedGuard = () => {
  const isAuthenticated = !!sessionStorage.getItem("authToken");
  const location = useLocation();

  if(!isAuthenticated) return(<Navigate to='/login'
    state={{ from: location.pathname }}
    replace
  />);

  return(
    <>
      <Logout/>
      <Outlet />
    </>
  );
};

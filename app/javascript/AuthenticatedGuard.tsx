import React, { useState, useEffect } from 'react';
import { Navigate, useLocation, Outlet } from 'react-router-dom';
import { Logout } from './components/Logout';
import { LoginAlert } from './components/LoginAlert';

interface State {
  loginAlert: boolean;
};

export const AuthenticatedGuard = () => {
  const isAuthenticated = !!sessionStorage.getItem("authToken");
  const location = useLocation();
  const { loginAlert } = (location.state as State) || {};
  const [showAlert, setShowAlert] = useState(false);

  useEffect(() => {
    if(loginAlert) setShowAlert(true);
  }, [loginAlert]);

  if(!isAuthenticated) return(<Navigate to='/login'
    state={{ from: location.pathname }}
    replace
  />);

  return(
    <>
      <LoginAlert showFlag={showAlert} setShowAlert={setShowAlert} />
      <Logout/>
      <Outlet />
    </>
  );
};

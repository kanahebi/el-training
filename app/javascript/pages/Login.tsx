import React from 'react';
import { useMutation } from "@apollo/client";
import { useNavigate, useLocation } from "react-router-dom";
import { LOGIN } from '../graphql/mutation'

interface State {
  from: any;
}

export const Login = () => {
  const navigate = useNavigate();
  let inputEmail: HTMLInputElement;
  let inputPassword: HTMLInputElement;
  const location = useLocation();
  const { from } = location?.state as State || {};;
  const [createTask, { loading, error }] = useMutation(LOGIN, {
    update(cache, { data }) {
      sessionStorage.setItem("authToken", data.login.token);
      if(from) navigate(from);
      navigate("/");
    }
  })

  if (loading) return <p>Submitting...</p>;

  return (
    <>
      <div className='main-content'>
        <div className="flex flex-col justify-center">
          <div className="mx-auto mt-5">
            {error ? <p>{error.message}</p> : <></>}
            <div className="block p-6 rounded-lg shadow-lg bg-white max-w-md">
              <form
                onSubmit={e => {
                  e.preventDefault();
                  createTask({
                    variables: {
                      email: inputEmail.value,
                      password: inputPassword.value,
                    }
                  });
                  inputEmail.value = "";
                  inputPassword.value = "";
                }}
              >
                <div className="form-group mb-6">
                  <label className="form-label inline-block mb-2 text-gray-700">メールアドレス</label>
                  <input ref={node => {
                      inputEmail = node;
                    }}
                    name="name"
                    type="text" className="form-control block
                    w-full
                    px-3
                    py-1.5
                    text-base
                    font-normal
                    text-gray-700
                    bg-white bg-clip-padding
                    border border-solid border-gray-300
                    rounded
                    transition
                    ease-in-out
                    m-0
                    focus:text-gray-700 focus:bg-white focus:border-blue-600 focus:outline-none" />
                </div>
                <div className="form-group mb-6">
                  <label className="form-label inline-block mb-2 text-gray-700">パスワード</label>
                  <input ref={node => {
                      inputPassword = node;
                    }}
                    name="email"
                    type="password" className="form-control block
                    w-full
                    px-3
                    py-1.5
                    text-base
                    font-normal
                    text-gray-700
                    bg-white bg-clip-padding
                    border border-solid border-gray-300
                    rounded
                    transition
                    ease-in-out
                    m-0
                    focus:text-gray-700 focus:bg-white focus:border-blue-600 focus:outline-none" />
                </div>
                <button type="submit" className="
                  w-full
                  px-6
                  py-2.5
                  bg-blue-600
                  text-white
                  font-medium
                  text-xs
                  leading-tight
                  uppercase
                  rounded
                  shadow-md
                  hover:bg-blue-700 hover:shadow-lg
                  focus:bg-blue-700 focus:shadow-lg focus:outline-none focus:ring-0
                  active:bg-blue-800 active:shadow-lg
                  transition
                  duration-150
                  ease-in-out">ログイン</button>
              </form>
            </div>
          </div>
        </div>
      </div>
    </>
  );
};

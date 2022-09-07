import React, { useState, useEffect } from 'react'
import { useQuery, useMutation, gql } from "@apollo/client";
import { useNavigate, useLocation, Link } from "react-router-dom";
import { Alert } from "../components/Alert";
import { GET_TASKS } from '../graphql/query'

interface State {
  alert: string;
};

export const Tasks = () => {
  const navigate = useNavigate();
  const location = useLocation();
  const { alert } = (location.state as State) || {};
  const [showAlert, setShowAlert] = useState(false);
  const {loading, error, data} = useQuery(GET_TASKS);

  const ShowTask = (id) => {
    navigate(`/tasks/${id}`, { state: { background: location }},);
  };

  useEffect(() => {
    if(alert) setShowAlert(true);
  }, [alert]);

  if (loading) return (<div>'ロード中....'</div>);
  if (error) return (<div>`Error ${error.message}`</div>);

  return (
    <div className='main-content'>
      <div className='flex flex-col justify-center'>
        <Alert showFlag={showAlert} setShowAlert={setShowAlert} content={alert} />
        <div className="mx-auto mt-5">
          <Link to='/tasks/new' type="button" className="inline-block
            bg-white
            px-6
            py-2
            border-2
            border-blue-400
            text-blue-400
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
          >タスクを追加</Link>
        </div>
        {data.tasks.length ? (data.tasks.map(task => (
          <div className="m-5" key={ task.id }>
            <div className="block p-6 rounded-lg shadow-lg bg-white max-w-sm mx-auto" onClick={() => {
              ShowTask(task.id);
            }}>
              <h5 className="text-gray-900 text-xl leading-tight font-medium mb-2">{ task.name }</h5>
              <p className="text-gray-700 text-base mb-4">{ task.description }</p>
            </div>
          </div>
        ))) : (
          <div>タスクはありません。</div>
        )}
      </div>
    </div>
  )
};

import React, { useState, useEffect } from 'react'
import { useQuery, gql } from "@apollo/client";
import { Link, useParams, useNavigate } from "react-router-dom";
import { Modal } from "../components/Modal";

const GET_TASK = gql`
  query GetTask($id: ID!) {
    task(id: $id) {
      id
      name
      description
    }
  }
`;

type RouterParams = {
  id: string;
};

export const Task = (props) => {
  const [showModal, setShowModal] = useState(false);
  const [deleteConfirm, setDeleteConfirm] = useState(false);
  const navigate = useNavigate();
  const { id } = useParams<RouterParams>();
  const { loading, error, data } = useQuery(GET_TASK, {
    variables: { id: id },
  });

  const handleClose = () => {
    props.setShowModal(false);
    navigate(-1);
  };

  const ShowModal = () => {
    setShowModal(true);
  };

  const MoveEditPage = () => {
    navigate(`/tasks/${id}/edit`);
  };

  if (loading) return (<div>'ロード中....'</div>);
  if (error) return (<div>`Error ${error.message}`</div>);

  return (
    <>
      {props.showFlag ? (
        <div className='main-content'>
          <div className="flex justify-center">
            <div className="modal fade fixed top-0 left-0 hidden w-full h-full outline-none overflow-x-hidden overflow-y-auto" aria-hidden="true">
              <div className="modal-dialog relative w-auto pointer-events-none">
                <div
                  className="modal-content border-none shadow-lg relative flex flex-col w-full pointer-events-auto bg-white bg-clip-padding rounded-md outline-none text-current">
                  <div
                    className="modal-header flex flex-shrink-0 items-center justify-between p-4 border-b border-gray-200 rounded-t-md">
                    <h5 className="text-xl font-medium leading-normal text-gray-800" id="exampleModalLabel">{ data.task.name }</h5>
                    <button type="button"
                      className="btn-close box-content w-4 h-4 p-1 text-black border-none rounded-none opacity-50 focus:shadow-none focus:outline-none focus:opacity-100 hover:text-black hover:opacity-75 hover:no-underline"
                      data-bs-dismiss="modal" aria-label="Close"></button>
                  </div>
                  <div className="modal-body relative p-4">
                    { data.task.description }
                  </div>
                  <div className="modal-footer flex flex-shrink-0 flex-wrap items-center justify-end p-4 border-t border-gray-200 rounded-b-md">
                    <button type="button" className="px-6
                      py-2.5
                      bg-red-600
                      text-white
                      font-medium
                      text-xs
                      leading-tight
                      uppercase
                      rounded
                      shadow-md
                      hover:bg-red-700 hover:shadow-lg
                      focus:bg-red-700 focus:shadow-lg focus:outline-none focus:ring-0
                      active:bg-red-800 active:shadow-lg
                      transition
                      duration-150
                      ease-in-out" onClick={ShowModal}>削除</button>
                    <button type="button" className="px-6
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
                      ease-in-out
                      ml-1" onClick={MoveEditPage}>編集</button>
                  </div>
                </div>
              </div>
            </div>
          </div>
          <Modal showFlag={showModal} setShowModal={setShowModal} setDeleteConfirm={setDeleteConfirm} content="本当に削除しますか？" />
        </div>
      ) : (
        <></>
      )}
    </>
  )
};

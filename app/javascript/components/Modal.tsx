import React from "react";

export const Modal = (props) => {
  const cancel = () => {
    props.setShowModal(false);
  };

  const confirmDelete = () => {
    props.setShowModal(false);
    props.setDeleteConfirm(true);
  };

  return (
    <>
      {props.showFlag ? (
        <div className="flex justify-center">
          <div className="block p-6 rounded-lg shadow-lg bg-white max-w-sm">
            <h5 className="text-gray-900 text-xl leading-tight font-medium mb-2">確認</h5>
            <p className="text-gray-700 text-base mb-4">{props.content}</p>
            <button type="button" className="mx-4 inline-block px-6 py-2.5 bg-red-600 text-white font-medium text-xs leading-tight uppercase rounded shadow-md hover:bg-blue-700 hover:shadow-lg focus:bg-blue-700 focus:shadow-lg focus:outline-none focus:ring-0 active:bg-red-800 active:shadow-lg transition duration-150 ease-in-out" onClick={confirmDelete}>削除</button>
            <button type="button" className="mx-4 inline-block px-6 py-2.5 bg-blue-600 text-white font-medium text-xs leading-tight uppercase rounded shadow-md hover:bg-blue-700 hover:shadow-lg focus:bg-blue-700 focus:shadow-lg focus:outline-none focus:ring-0 active:bg-blue-800 active:shadow-lg transition duration-150 ease-in-out" onClick={cancel}>キャンセル</button>
          </div>
        </div>
      ) : (
        <></>
      )}
    </>
  );
};

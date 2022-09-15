import React from "react";
import { Link } from "react-router-dom";

export const Paginate = (props) => {
  return (
    <>
      <div className="block max-w-sm mx-auto">
        {[...Array(props.pageInfo.totalPages)].map((_, i) => (
          <span key={i+1}>
            { (i+1 == props.pageInfo.currentPage) ? <button className="
                bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 border border-blue-700 rounded"
              >{i+1}</button> : <Link to={`/tasks?page=${i+1}`} type="button" className="
                bg-transparent hover:bg-blue-500 text-blue-700 font-semibold hover:text-white py-2 px-4 border border-blue-500 hover:border-transparent rounded mx-1"
              >{i+1}</Link>
            }
          </span>
        ))}
      </div>
    </>
  )
};

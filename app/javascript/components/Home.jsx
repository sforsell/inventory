import React from "react";
import { Link } from "react-router-dom";

export default () => (
  <div className="vw-100 vh-100 primary-color d-flex align-items-center justify-content-center">
    <div className="jumbotron jumbotron-fluid bg-transparent">
      <div className="container secondary-color">
        <h1 className="display-4">Inventory</h1>
        <p className="lead">
          Keep track of items needed for your products.
        </p>
        <hr className="my-4" />
        <Link
          to="/recipes"
          className="btn btn-lg custom-button"
          role="button"
        >
          View Menu
        </Link>
        <Link
          to="/inventory/delivery"
          className="btn btn-lg custom-button"
          role="button"
        >
          Register Delivery
        </Link>
      </div>
    </div>
  </div>
);

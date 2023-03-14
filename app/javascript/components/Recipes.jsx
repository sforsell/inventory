import React, { useState, useEffect } from "react";
import { Link, useNavigate } from "react-router-dom";

const Recipes = () => {
  const navigate = useNavigate();
  const [recipes, setRecipes] = useState([]);

  useEffect(() => {
    const url = "/recipes";
    fetch(url)
      .then((res) => {
        if (res.ok) {
          return res.json();
        }
        throw new Error("Network response was not ok.");
      })
      .then((res) => setRecipes(res))
      .catch(() => navigate("/"));
  }, []);

  const allRecipes = recipes.map((recipe) => (
    <div key={recipe.id} className="col-md-6 col-lg-4">
      <div className="card mb-4">
        <div className="card-body">
          <h5 className="card-title">{recipe.name}</h5>
          <h6 class="card-subtitle mb-2 text-muted"> {recipe.price} </h6>
          <button type="button" class="btn btn-secondary btn-lg" disabled>Sell item</button>
        </div>
      </div>
    </div>
  ));
  const noRecipe = (
    <div className="vw-100 vh-50 d-flex align-items-center justify-content-center">
      <h4>
        No recipes yet...
      </h4>
    </div>
  );

  return (
    <>
      <section className="jumbotron jumbotron-fluid text-center">
        <Link to="/" className="btn btn-link ">
          Home
        </Link>
        <div className="container py-5">
          <h1 className="display-4">Available menu items</h1>
        </div>
      </section>
      <div className="py-5">
        <main className="container">
          <div className="row">
            {recipes.length > 0 ? allRecipes : noRecipe}
          </div>
        </main>
      </div>
    </>
  );
};




export default Recipes;

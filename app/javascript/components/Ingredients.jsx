import React, { useState, useEffect } from "react";
import { Link, useNavigate } from "react-router-dom";

const Ingredients = () => {
  const navigate = useNavigate();
  const [ingredients, setInventory] = useState([]);

  useEffect(() => {
    const url = "/inventory/delivery";
    fetch(url)
      .then((res) => {
        if (res.ok) {
          return res.json();
        }
        throw new Error("Network response was not ok.");
      })
      .then((res) => setInventory(res))
      .catch(() => navigate("/"));
  }, []);

  const allIngredients = ingredients.map((ingredient) => (
    <div key={ingredient.id}>
      <div class="form-group row">
        <label for="{ingredient.id}" class="col-sm-6 col-form-label col-form-label-sm ">
          {ingredient.name}, price per {ingredient.unit}: {ingredient.price}. Current amount: {ingredient.inventory} +
        </label>
        <div class="col-sm-1">
          <input type="text" class="form-control form-control-sm" id="{ingredient.id}" placeholder="0.0" />
        </div>
      </div>
    </div>
  ));
  const noInventory = (
    <div className="vw-100 vh-50 d-flex align-items-center justify-content-center">
      <h4>
        No inventory...
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
          <h1 className="display-4">Inventory - register delivery</h1>
        </div>
      </section>
      <div className="py-5">
        <main className="container">
          <form>
            {ingredients.length > 0 ? allIngredients : noInventory}
            <button type="submit" class="btn btn-primary">Add delivery amounts</button>
          </form>
        </main>
      </div>
    </>
  );
};

export default Ingredients;

import React, { useState, useEffect } from "react";
import { Link, useNavigate } from "react-router-dom";

const Ingredients = () => {
  const navigate = useNavigate();
  const [ingredients, setInventory] = useState([]);
  const [inventory, addInventory] = useState({});

  const handleChange = (event) => {
    addInventory({...inventory, [event.target.name] : event.target.value});
  };

  const resetForm = () => {
    document.getElementById("reset-after-send").reset();
  };

  const onSubmit = (event) => {
    event.preventDefault();
    const url = "/inventory/delivery";

    if (inventory.obj && Object.keys(inventory).length === 0 && Object.getPrototypeOf(inventory) === Object.prototype)
      return;

    const body = {
      inventory
    };
    const token = document.querySelector('meta[name="csrf-token"]').content;
    fetch(url, {
      method: "POST",
      headers: {
        "X-CSRF-Token": token,
        "Content-Type": "application/json",
      },
      body: JSON.stringify(body),
    })
      .then((res) => {
        if (res.ok) {
          return res.json();
        }
        throw new Error("Network response was not ok.");
      })
      .then((res) => setInventory(res))
      .then(() => resetForm())
      .catch((error) => console.log(error.message));
  };

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
      <div className="form-group row">
        <label htmlFor={ingredient.name} className="col-sm-6 col-form-label col-form-label-sm ">
          {ingredient.name}, price per {ingredient.unit}: {ingredient.price}. Current amount: {ingredient.inventory} +
        </label>
        <div className="col-sm-1">
          <input type="number" className="form-control form-control-sm" id={ingredient.name} name={ingredient.id} placeholder={0.0} onChange={handleChange}/>
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
          <form id="reset-after-send" onSubmit={onSubmit}>
            {ingredients.length > 0 ? allIngredients : noInventory}
            <button type="submit" className="btn btn-primary">Add delivery amounts</button>
          </form>
        </main>
      </div>
    </>
  );
};

export default Ingredients;

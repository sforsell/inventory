class Recipe < ApplicationRecord
  has_many :location_recipes, dependent: :destroy
  has_many :locations, through: :location_recipes
  has_many :recipe_ingredients
  has_many :ingredients, through: :recipe_ingredients
end

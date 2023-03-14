class Location < ApplicationRecord
  has_many :employee_locations, dependent: :destroy
  has_many :employees, through: :employee_locations

  has_many :location_recipes, dependent: :destroy
  has_many :recipes, through: :location_recipes
  has_many :recipe_ingredients, through: :location_recipes
  has_many :ingredients, through: :recipe_ingredients
  has_many :ingredient_inventories, class_name: 'LocationIngredient'
end

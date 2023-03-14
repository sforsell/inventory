class Ingredient < ApplicationRecord
  has_many :recipe_ingredients
  has_many :recipes, through: :recipe_ingredients

  has_many :ingredient_inventories, class_name: 'LocationIngredient'
end

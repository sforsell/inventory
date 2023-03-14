class Location < ApplicationRecord
  has_many :employee_locations, dependent: :destroy
  has_many :employees, through: :employee_locations

  has_many :location_recipes, dependent: :destroy
  has_many :recipes, through: :location_recipes
  has_many :recipe_ingredients, through: :location_recipes
  has_many :ingredients, through: :recipe_ingredients
  has_many :ingredient_inventories, class_name: 'LocationIngredient'
  has_many :inventory_updates

  before_save :set_parameterized_name, if: :will_save_change_to_name?

  private

  def set_parameterized_name
    self.parameterized_name = name.parameterize
  end
end

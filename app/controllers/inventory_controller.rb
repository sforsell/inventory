class InventoryController < ApplicationController
  before_action :set_location
  def index; end

  def recipes
    # TODO: filter to show only where inventory is enough to fulfill order
    # add method in LocationRecipes I think.
    recipes = @location.location_recipes.includes(:recipe).map { |lc| lc.recipe.as_json.merge(lc.as_json) }
    render json: recipes
  end

  def show_inventory
    inventory = @location.ingredient_inventories
                         .includes(:ingredient)
                         .joins(:ingredient)
                         .order('ingredients.name')
                         .map do |ii|
                           ii.ingredient.as_json.merge(ii.as_json)
                         end
    render json: inventory
  end

  private

  def set_location
    @location = Location.find_by!(parameterized_name: request.subdomain)
  end
end

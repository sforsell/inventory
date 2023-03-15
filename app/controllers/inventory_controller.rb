class InventoryController < ApplicationController
  include InventoryHelper

  before_action :set_location
  def index; end

  def recipes
    # TODO: filter to show/highlight only where inventory is enough to
    # fulfill order. add method in LocationRecipes I think.
    recipes = @location.location_recipes.includes(:recipe).map { |lc| lc.recipe.as_json.merge(lc.as_json) }
    render json: recipes
  end

  def show_inventory
    inventory = ordered_inventory_for_location(@location)
    render json: inventory
  end

  def delivery
    delivery_params[:inventory].each do |id, amount|
      curr_inventory = LocationIngredient.find(id)
      curr_inventory.transaction do
        old_value = curr_inventory.inventory
        InventoryUpdate.create!(
          location: @location,
          location_ingredient: curr_inventory,
          action: 'delivery',
          old_value:,
          new_value: old_value + amount.to_f
        )
        curr_inventory.inventory += amount.to_f
        curr_inventory.save!
      end
    end
    render json: ordered_inventory_for_location(@location)
  end

  private

  def delivery_params
    params.permit(inventory: {})
  end

  def set_location
    @location = Location.find_by!(parameterized_name: request.subdomain)
  end
end

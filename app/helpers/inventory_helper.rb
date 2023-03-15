module InventoryHelper
  def ordered_inventory_for_location(location)
    location.ingredient_inventories
            .includes(:ingredient)
            .joins(:ingredient)
            .order('ingredients.name')
            .map do |ii|
              ii.ingredient.as_json.merge(ii.as_json)
            end
  end
end

class InventoryUpdate < ApplicationRecord
  include Locationable
  belongs_to :location
  belongs_to :location_ingredient
  has_one :inventory_ingredient, through: :location_ingredient, class_name: 'Ingredient'
end

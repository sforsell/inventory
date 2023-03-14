class LocationIngredient < ApplicationRecord
  belongs_to :location
  belongs_to :ingredient
end

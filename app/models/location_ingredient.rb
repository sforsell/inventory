class LocationIngredient < ApplicationRecord
  include Locationable
  belongs_to :location
  belongs_to :ingredient
end

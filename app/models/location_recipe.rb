class LocationRecipe < ApplicationRecord
  belongs_to :location
  belongs_to :recipe
end

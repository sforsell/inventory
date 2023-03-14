class LocationRecipe < ApplicationRecord
  include Locationable
  belongs_to :location
  belongs_to :recipe
end

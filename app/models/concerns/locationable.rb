module Locationable
  extend ActiveSupport::Concern

  included do
    scope :for_location, ->(location) { where(location_id: location.id) }
  end
end

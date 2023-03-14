class EmployeeLocation < ApplicationRecord
  include Locationable
  belongs_to :employee
  belongs_to :location
end

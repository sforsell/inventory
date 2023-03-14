class Employee < ApplicationRecord
  has_many :employee_locations, dependent: :destroy
  has_many :locations, through: :employee_locations
end

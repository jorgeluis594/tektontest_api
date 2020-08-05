class Employee < ApplicationRecord
  has_many :subordinates, class_name: 'Employee', foreign_key: 'manager_id'
  has_many :expenses

  belongs_to :manager, class_name: 'Employee', optional: true

  validates :name, :birth_date, :dni, :email, :position, presence: true
  validates :activated, inclusion: { in: [true, false] }
end

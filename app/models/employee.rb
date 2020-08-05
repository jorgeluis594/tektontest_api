class Employee < ApplicationRecord
  has_many :subordinates, class_name: 'Employee', foreign_key: 'manager_id'
  has_many :expenses

  belongs_to :manager, class_name: 'Employee', optional: true

  enum :position => { manager: 0, collaborator: 1 }

  validates :name, :birth_date, :dni, :email, :position, presence: true
  validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i }
  validates :activated, inclusion: { in: [true, false] }
end

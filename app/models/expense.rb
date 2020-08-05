class Expense < ApplicationRecord
  belongs_to :employee

  validates :category, :cost, :currency_type, :description, :release_date, presence: true
end

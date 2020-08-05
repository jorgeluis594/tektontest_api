class Product < ApplicationRecord
  has_many :invoice_items

  validates :currency_type, :name, :price, presence: true
end

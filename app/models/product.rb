class Product < ApplicationRecord
  has_many :invoice_items
  enum :currency_type => {PEN: 0, US: 1}
  validates :currency_type, :name, :price, presence: true
end

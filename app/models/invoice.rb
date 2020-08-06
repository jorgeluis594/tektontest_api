class Invoice < ApplicationRecord
  has_many :invoice_items
  has_many :products, through: :invoice_items

  validates :ruc, numericality: true
end

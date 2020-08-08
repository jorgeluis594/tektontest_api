class Invoice < ApplicationRecord
  has_many :invoice_items
  has_many :products, through: :invoice_items

  validates :ruc, numericality: true

  def get_invoice_value
    invoice_items.reduce(Hash.new(0)) do |currency_type,item|
      product = item.product
      currency_type[product['currency_type']] += item['quantity']*product['price']
      currency_type
    end
  end
end

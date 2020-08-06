FactoryBot.define do
  factory :invoice_item do
    quantity { rand(5) }
    Invoice
    Product
  end
end

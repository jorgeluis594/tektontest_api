class Expense < ApplicationRecord
  enum :category => { compras: 0, "pago de planilla": 1, "gastos administrativos": 2, otros: 3 }
  enum :currency_type => {PEN: 0, US: 1}
  validates :category, :cost, :currency_type, :description, :release_date, presence: true
end

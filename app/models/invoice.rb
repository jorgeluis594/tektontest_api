class Invoice < ApplicationRecord
  validates :ruc, numericality: true
end

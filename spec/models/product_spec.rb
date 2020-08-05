require 'rails_helper'

RSpec.describe Product, type: :model do
  it 'Validate presence of required attributes' do
    should validate_presence_of(:name)
    should validate_presence_of(:price)
    should validate_presence_of(:currency_type)
  end
  it 'Validate relations' do
    should have_many(:invoice_items)
  end
end

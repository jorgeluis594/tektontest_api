require 'rails_helper'

RSpec.describe InvoiceItem, type: :model do
  it 'Validate presence of required attributes' do
    should validate_presence_of(:quantity)
  end

  it 'Validate relations' do
    should belong_to(:invoice)
    should belong_to(:product)
  end
end

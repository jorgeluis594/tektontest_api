require 'rails_helper'

RSpec.describe Invoice, type: :model do

  it 'Validate Ruc' do
    should validate_numericality_of(:ruc)
  end

  it 'Validate relations' do
    should have_many(:products)
  end
end

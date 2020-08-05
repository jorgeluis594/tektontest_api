require 'rails_helper'

RSpec.describe Invoice, type: :model do

  it 'Validate Ruc' do
    should validate_numericality_of(:ruc)
  end
end

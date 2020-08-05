require 'rails_helper'

RSpec.describe Expense, type: :model do

  describe "validations" do
    it 'Validate presence of required attributes' do
      should validate_presence_of(:release_date)
      should validate_presence_of(:category)
      should validate_presence_of(:cost)
      should validate_presence_of(:currency_type)
      should validate_presence_of(:description)
    end

    it 'Validate relations' do
      should belong_to(:employee)
    end
  end
end

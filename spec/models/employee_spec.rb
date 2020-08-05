require 'rails_helper'

RSpec.describe Employee, type: :model do

  describe "validations" do
    it 'Validate presence of required attributes' do
      should validate_presence_of(:name)
      should validate_presence_of(:dni)
      should validate_presence_of(:email)
      should validate_presence_of(:birth_date)
      should validate_presence_of(:position)
    end

    it 'Validate relations' do
      should have_many(:expenses)
    end
  end
end

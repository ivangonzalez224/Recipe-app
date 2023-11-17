require 'rails_helper'

RSpec.describe Food, type: :model do
  describe 'validations' do
    let(:user) { User.new(name: 'Kobe') }

    it 'is valid with valid attributes' do
      food = Food.new(user: user, name: 'Apple', measurement_unit: 'g', price: 3, quantity: 500)
      expect(food).to be_valid
    end

    it 'is not valid with valid without user association' do
        food = Food.new(name: 'Apple', measurement_unit: 'g', price: 3, quantity: 500)
        expect(food).to_not be_valid
      end

      it 'is not valid without a name' do
        food = Food.new(user: user, measurement_unit: 'g', price: 5, quantity: 1000)
        expect(food).to_not be_valid
      end  
  end  
end    
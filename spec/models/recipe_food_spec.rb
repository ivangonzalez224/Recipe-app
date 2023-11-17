require 'rails_helper'

RSpec.describe RecipeFood, type: :model do
  describe 'validations' do
    let(:user) { User.new(name: 'Kobe', id: 1) }
    let(:recipe) do
      Recipe.new(id: 2, user: user, name: 'Apple Pie', preparation_time: 30, cooking_time: 60,
                 description: 'A delicious apple pie', public: true)
    end
    let(:food) { Food.new(id: 3, user: user, name: 'Apple', measurement_unit: 'g', price: 3, quantity: 500) }

    it 'is valid with valid attributes' do
      recipe_food = RecipeFood.new(recipe: recipe, food: food, quantity: 500)
      expect(recipe_food).to be_valid
    end

    it 'is not valid without a recipe' do
      recipe_food = RecipeFood.new(food: food, quantity: 500)
      expect(recipe_food).to_not be_valid
    end

    it 'is not valid without a food' do
      recipe_food = RecipeFood.new(recipe: recipe, quantity: 500)
      expect(recipe_food).to_not be_valid
    end

    it 'is not valid without a quantity' do
      recipe_food = RecipeFood.new(recipe: recipe, food: food)
      expect(recipe_food).to_not be_valid
    end
  end
end

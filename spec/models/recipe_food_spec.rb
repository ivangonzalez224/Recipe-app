require 'rails_helper'

RSpec.describe RecipeFood, type: :model do
  describe 'validations' do
    let(:user) { User.new(name: 'Kobe') }
    let(:recipe) { Recipe.new(user: user, name: 'Apple Pie', preparation_time: 30, cooking_time: 60, description: 'A delicious apple pie', public: true) }
    let(:food) { Food.new(name: 'Apple', price: 10) }

    it 'is valid with valid attributes' do
      recipe_food = RecipeFood.new(recipe_id: recipe, food_id: food, quantity: 2)
      expect(recipe_food).to be_valid
    end

    it 'is not valid without a quantity' do
      recipe_food = RecipeFood.new(recipe: recipe, food: food)
      expect(recipe_food).to_not be_valid
    end

    it 'is not valid with a negative quantity' do
      recipe_food = RecipeFood.new(recipe: recipe, food: food, quantity: -2)
      expect(recipe_food).to_not be_valid
    end

    it 'is not valid without a recipe' do
      recipe_food = RecipeFood.new(food: food, quantity: 2)
      expect(recipe_food).to_not be_valid
    end

    it 'is not valid without a food' do
      recipe_food = RecipeFood.new(recipe: recipe, quantity: 2)
      expect(recipe_food).to_not be_valid
    end

    it 'is not valid with a duplicate food in the same recipe' do
      recipe_food = RecipeFood.new(recipe: recipe, food: food, quantity: 2)
      recipe_food.save
      recipe_food2 = RecipeFood.new(recipe: recipe, food: food, quantity: 2)
      expect(recipe_food2).to_not be_valid
    end
  end
end

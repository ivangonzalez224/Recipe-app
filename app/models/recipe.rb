class Recipe < ApplicationRecord
  belongs_to :user
  has_many :recipe_foods, dependent: :destroy

  validates :name, presence: true
  validates :preparation_time, presence: true
  validates :cooking_time, presence: true
  validates :description, presence: true

  def total_price
    tot_prices = []

    foods.each do |food|
      recipe_food = RecipeFood.find_by(recipe_id: id, food_id: food.id)
      food_price = (recipe_food.quantity * food.price)
      prices.push(food_price)
    end
    tot_prices.sum
  end

  def give_price
    recipe_foods.sum { |rf| rf.quantity * rf.food.price }
  end
end

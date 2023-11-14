class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

  has_many :recipes
  has_many :foods

  validates :name, presence: true

  # Returning a list of all foods that are used in all of the user's recipes
  def all_food_used
    foods = []
    recipes.each do |recipe|
      recipe.foods.each do |food|
        foods << food
      end
    end
    foods
  end
end

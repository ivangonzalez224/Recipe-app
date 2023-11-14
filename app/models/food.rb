class Food < ApplicationRecord
  has_many :recipe_foods
  has_many :recipes
  belongs_to :user
end

class FoodsController < ApplicationController
  before_action :find_food, only: %i[show edit update destroy]
  def index
    @foods = if params[:order_by] == 'name'
               current_user.foods.order('LOWER(name)')
             else
               current_user.foods
             end
  end

  def new
    @food = Food.new
  end

  private

  def find_food
    @food = Food.find(params[:id])
  end

  def food_params
    params.require(:food).permit(:name, :measurement_unit, :price, :quantity)
  end

  def clean_name(food_name)
    food_name.strip.downcase.titleize.singularize
  end
end

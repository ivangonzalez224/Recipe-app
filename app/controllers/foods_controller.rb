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

  def update_food(old_food)
    update_food_attributes(old_food)
    redirect_to foods_path, notice: 'The food was successfully updated.'
  end

  def update_food_attributes(food)
    new_quantity = food.quantity + food_params[:quantity].to_i
    old_cost = food.price * food.quantity
    new_cost = food_params[:price].to_f * food_params[:quantity].to_i
    total_cost = old_cost + new_cost
    new_unit_price = total_cost / new_quantity
    food.update(quantity: new_quantity, price: new_unit_price)
  end
end

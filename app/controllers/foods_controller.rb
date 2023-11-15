class FoodsController < ApplicationController
  before_action :authenticate_user!
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

  def create
    clean_new_name = clean_name(food_params[:name])
    old_food = current_user.foods.find_by(name: clean_new_name)

    if old_food
      update_food(old_food)
    else
      create_new_food(clean_new_name)
    end
  end

  def destroy
    @food = Food.find(params[:id])
    @food.destroy
    if @food.destroy
      flash[:notice] = 'Food deleted !'
    else
      flash[:alert] = 'The food could not be deleted !'
    end
    redirect_to foods_path
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

  def create_new_food(new_name)
    @food = current_user.foods.build(food_params.merge(name: new_name))
    if @food.save
      redirect_to foods_path, notice: 'The food was successfully created.'
    else
      render :new
    end
  end
end

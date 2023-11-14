class FoodsController < ApplicationController
  def index
    @foods = if params[:order_by] == 'name'
               current_user.foods.order('LOWER(name)')
             else
               current_user.foods
             end
  end
end

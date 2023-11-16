class RecipesController < ApplicationController
  before_action :authenticate_user!, except: [:public_recipes]
  # GET /recipes or /recipes.json
  def index
    @recipes = Recipe.where(user_id: current_user.id)
  end

  # GET /recipes/1 or /recipes/1.json
  def show
    @recipe = Recipe.find(params[:id])
    @ingredients = RecipeFood.where(recipe_id: @recipe.id)
    @foods = @recipe.recipe_foods
  end

  # GET /recipes/new
  def new
    @recipe = Recipe.new
  end

  # GET /recipes/1/edit
  def edit
    @recipe = Recipe.find(params[:id])
  end

  # POST /recipes or /recipes.json
  def create
    @recipe = Recipe.new(recipe_params)

    respond_to do |format|
      if @recipe.save
        format.html { redirect_to recipe_url(@recipe), notice: 'Recipe was successfully created.' }
        format.json { render :show, status: :created, location: @recipe }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @recipe.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /recipes/1 or /recipes/1.json
  def update
    @recipe = Recipe.find(params[:id])
    respond_to do |format|
      if @recipe.update(recipe_params)
        format.html { redirect_to recipe_url(@recipe), notice: 'Recipe was successfully updated.' }
        format.json { render :show, status: :ok, location: @recipe }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @recipe.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /recipes/1 or /recipes/1.json
  def destroy
    @recipe = Recipe.find(params[:id])
    @recipe.destroy!

    respond_to do |format|
      format.html { redirect_to recipes_url, notice: 'Recipe was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  # Public Recipes
  def public_recipes
    @recipes = Recipe.where(public: true)
  end

  def shopping_list
    @user = current_user
    @recipes = @user.recipes || []
    @user_stock = calculate_stock
    @foods_missing = calculate_missing
    @foods_missing = sort_foods_needed(@foods_missing)
    @buy_foods = calculate_buy(@foods_missing, @user_stock)
    @total_price = calculate_total_price
  end

  def sort_foods_needed(foods_missing)
    sort = params[:sort_param]
    case sort
    when 'name_asc'
      foods_missing.sort.to_h
    when 'name_desc'
      foods_missing.sort.reverse.to_h
    when 'price_asc'
      foods_missing.sort_by { |food_name, _| Food.getting_price(food_name) }.to_h
    when 'price_desc'
      foods_missing.sort_by { |food_name, _| Food.getting_price(food_name) }.reverse.to_h
    else
      foods_missing
    end
  end

  private

  def calculate_stock
    stock = {}
    @user.foods.each do |food|
      if stock.key?(food.name)
        stock[food.name] += food.quantity.to_i
      else
        stock[food.name] = food.quantity.to_i
      end
    end
    stock
  end

  def calculate_missing
    foods_missing = {}
    @user.recipes.includes(recipe_foods: :food).each do |recipe|
      recipe.recipe_foods.each do |recipe_food|
        food = recipe_food.food
        next if recipe_food.quantity.blank?

        if foods_missing.key?(food.name)
          foods_missing[food.name] += recipe_food.quantity.to_i
        else
          foods_missing[food.name] = recipe_food.quantity.to_i
        end
      end
    end
    foods_missing
  end

  def calculate_buy(foods_missing, user_stock)
    buy_foods = {}
    foods_missing.each do |k, v|
      quantity_missing = [0, v - (user_stock[k] || 0)].max
      buy_foods[k] = quantity_missing if quantity_missing.positive?
    end
    buy_foods
  end

  def calculate_total_price
    total_price = 0
    @foods_missing.each do |k, v|
      price = Food.getting_price(k)
      quantity_missing = [0, v - (@user_stock[k] || 0)].max
      total_price += quantity_missing * price
    end
    total_price
  end
  # Use callbacks to share common setup or constraints between actions.
  def set_recipe
    @recipe = Recipe.find(params[:id])
  end
 

  # Only allow a list of trusted parameters through.
  def recipe_params
    params.require(:recipe).permit(:name, :preparation_time, :description, :public, :user_id, :cooking_time)
  end
end

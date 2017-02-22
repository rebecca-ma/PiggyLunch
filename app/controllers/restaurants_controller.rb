class RestaurantsController < ApplicationController
  def index
    @restaurants = Restaurant.all
  end

  def show
    @restaurant = Restaurant.find(params[:id])
    if !@restaurant
      redirect_to restaurants_path
    end
  end

  def new
    @restaurant = Restaurant.new
  end

  def create
    @restaurant = Restaurant.new(restaurant_params)
    if @restaurant.save
      redirect_to show_restaurant_path(@restaurant)
    else
      render 'new'
    end
  end

  def edit
    @restaurant = Restaurant.find(params[:id])
    if !@restaurant
      redirect_to restaurants_path
    end
  end

  def update
    @restaurant = Restaurant.find(params[:id])
    if @restaurant.update
      redirect_to show_restaurant_path(@restaurant)
    else
      render 'edit'
    end
  end

  private
    def restaurant_params
      params.require(:restaurant).allow(:name, :description, :map_url, :tags)
    end
end

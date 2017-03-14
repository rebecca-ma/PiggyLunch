class PiggiesController < ApplicationController
  def new
    @piggy = Piggy.new
    @restaurant = Restaurant.find(params[:id])
  end

  def create
    @piggy = Piggy.new(piggy_params)
    if @piggy.save
      redirect_to show_restaurant_path(params[:id])
    else
      @restaurant = Restaurant.find(params[:id])
      render 'new'
    end
  end

  def edit
    @piggy = Piggy.find(params[:id])
    @restaurant = Restaurant.find(params[:restaurant_id])
  end

  def update
    @piggy = Piggy.find(params[:id])
    if @piggy.update(piggy_params)
      redirect_to show_restaurant_path(params[:restaurant_id])
    else
      render 'edit'
    end
  end

  private
    def piggy_params
      params.require(:piggy).permit(:user_id, :restaurant_id, :score, :comment)
    end
end

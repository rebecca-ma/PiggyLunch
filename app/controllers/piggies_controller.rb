class PiggiesController < ApplicationController
  def new
    @piggy = Piggy.new
  end

  def create
    @piggy = Piggy.new(piggy_params)
    if @piggy.save
      redirect_to show_restaurant_path(params[:restaurant_id])
    else
      render 'new'
    end
  end

  def edit
    @piggy = Piggy.find(params[:id])
    if !@piggy
      redirect_to show_restaurant_path(params[:restaurant_id])
    end
  end

  def update
    @piggy = Piggy.find(params[:id])
    if @piggy.update
      redirect_to show_restaurant_path(params[:restaurant_id])
    else
      render 'edit'
    end
  end

  private
    def piggy_params
      params.require(:piggy).allow(:user, :restaurant, :score, :comment)
    end
end

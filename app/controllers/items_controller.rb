class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new]

  def index
    @items = Item.order(created_at: :desc)
  end

  def new 
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @item = Item.find(params[:id])
  end

  def edit 
    @item = Item.find(params[:id])
      unless @item.user == current_user
        redirect_to root_path
      end
  end

  def update
    item = Item.find(params[:id])
    if item.update(item_params)
      redirect_to root_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def item_params
    params.require(:item).permit(:item_name, :item_description, :item_category_id, :item_condition_id, :shipping_cost_id, :shipping_area_id, :delivery_time_id, :image, :price)
    .merge(user_id: current_user.id)
  end
end

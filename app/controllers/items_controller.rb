class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :edit]
  before_action :set_item, only: [:show, :edit, :update, :destroy]
  before_action :move_to_index, only: [:edit, :destroy]
  def index
    @items = Item.order(created_at: :desc)
  end

  def new 
    @item = Item.new
    @maincategories = Category.all.order("id ASC").limit(13)
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
  end

  def edit 
    if Order.exists?(item_id: @item.id)
      redirect_to root_path
      return
    end
  end

  def update
    if @item.update(item_params)
      redirect_to item_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @item.destroy
    redirect_to root_path
  end

  private

  def item_params
    params.require(:item).permit(:item_name, :item_description, :ancestry, :item_condition_id, :shipping_cost_id, :shipping_area_id, :delivery_time_id, :price, {images: []})
    .merge(user_id: current_user.id)
  end

  def set_item
    @item = Item.find(params[:id])
  end

  def move_to_index
    unless @item.user == current_user
      redirect_to root_path
    end
  end
end

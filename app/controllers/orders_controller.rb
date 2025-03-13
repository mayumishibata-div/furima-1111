class OrdersController < ApplicationController
  before_action :set_item, only: [:index, :create ]

  def index
    @order = Order.new
    @order_shipping_address = OrderShippingAddress.new
  end

  def new
    @order = Order.new
  end

  def create
    @order_shipping_address = OrderShippingAddress.new(order_shipping_address_params)
    if @order_shipping_address.valid?
      @order_shipping_address.save
      redirect_to root_path
    else
      render :index, status: :unprocessable_entity
    end
  end

  private
  def order_shipping_address_params
    params.require(:order_shipping_address).permit(:post_code, :shipping_area_id, :city, :address, :building_name, :tel_number).merge(item_id: params[:item_id], user_id: current_user.id, token: params[:token])
  end

  def set_item
    @item = Item.find(params[:item_id])
  end
end
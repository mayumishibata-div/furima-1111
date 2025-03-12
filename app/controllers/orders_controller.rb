class OrdersController < ApplicationController

  def index
    @item = Item.find(params[:item_id])
    @order = Order.new
    @order_shipping_address = OrderShippingAddress.new
  end

  def new
    @order = Order.new
  end

  def create
    @item = Item.find(params[:item_id])
    @order_shipping_address = OrderShippingAddress.new(order_shipping_address_params)
    if @order_shipping_address.valid?
      @order_shipping_address.save
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  private
  def order_shipping_address_params
    params.require(:order_shipping_address).permit(:post_code, :shipping_area_id, :city, :address, :building_name, :phone_number).merge(item_id: params[:item_id]) 
  end

  def shipping_address_params
    params.permit(:postal_code, :prefecture, :city, :house_number, :building_name).merge(donation_id: @donation.id)
  end
end

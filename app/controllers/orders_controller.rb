class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_item, only: [:index, :create ]

  def index
    if Order.exists?(item_id: @item.id)
      redirect_to root_path
      return
    end

    if current_user.id == @item.user_id
      redirect_to root_path
    end

    gon.public_key = ENV["PAYJP_PUBLIC_KEY"]
    @order = Order.new
    @order_shipping_address = OrderShippingAddress.new
  end

  def new
    @order = Order.new
  end

  def create
    @order_shipping_address = OrderShippingAddress.new(order_shipping_address_params)
    if @order_shipping_address.valid?
      pay_item
      @order_shipping_address.save
      redirect_to root_path
    else
      gon.public_key = ENV["PAYJP_PUBLIC_KEY"]
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

  def pay_item
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]  # 自身のPAY.JPテスト秘密鍵を記述しましょう
    Payjp::Charge.create(
      amount: @item.price,
      card: order_shipping_address_params[:token],    # カードトークン
      currency: 'jpy'                 # 通貨の種類（日本円）
    )
  end
end
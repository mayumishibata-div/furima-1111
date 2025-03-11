class OrderShippingAddress
  include ActiveModel::Model
  attr_accessor :post_code, :shipping_area_id, :city, :address, :building_name, :tel_number, :order
end
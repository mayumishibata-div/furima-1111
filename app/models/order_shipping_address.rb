class OrderShippingAddress
  include ActiveModel::Model
  attr_accessor :post_code, :shipping_area_id, :city, :address, :building_name, :tel_number, :order, :user_id, :item_id

  with_options presence: true do
    # 郵便番号は、「3桁ハイフン4桁」の半角文字列のみ保存可能
    validates :post_code, format: { with: /\A\d{3}-\d{4}\z/, message: "は「XXX-XXXX」の形式で入力してください" }
    # 都道府県id: 1, name: '---' }は登録できない
    validates :shipping_area_id, numericality: {other_than: 1, message: "can't be blank"}
    # 市区町村が必須であること。
    validates :city
    # 番地が必須であること。
    validates :address
    # 電話番号は、10桁以上11桁以内の半角数値のみ保存可能なこと（良い例：09012345678　良くない例：090-1234-5678）。
    validates :tel_number, format: { with: /\A\d{10,11}\z/, message: "は10桁以上11桁以内の半角数値で入力してください" }  # 電話番号のバリデーションを追加
    validates :user_id
  end
  

  def save
    # 購入情報を保存し、変数orderに代入する
    order = Order.create(item_id: item_id, user_id: user_id)
    # 住所を保存する
    # order_idには、変数orderのidと指定する
    ShippingAddress.create(post_code: post_code, shipping_area_id: shipping_area_id, city: city, address: address, building_name: building_name, tel_number: tel_number, order_id: order.id)
  end
end
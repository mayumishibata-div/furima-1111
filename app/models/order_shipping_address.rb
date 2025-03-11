class OrderShippingAddress
  include ActiveModel::Model
  attr_accessor :post_code, :shipping_area_id, :city, :address, :building_name, :tel_number, :order

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
    validates :phone_number, format: { with: /\A\d{10,11}\z/, message: "は10桁以上11桁以内の半角数値で入力してください" }  # 電話番号のバリデーションを追加
    validates :user_id
  end
  
end
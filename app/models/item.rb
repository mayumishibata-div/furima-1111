class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :item_category
  belongs_to :item_condition
  belongs_to :shipping_cost
  belongs_to :shipping_area
  belongs_to :delivery_time
  belongs_to :user
  has_one :order
  # has_one_attached :image
  has_many_attached :images

  # validates :image, presence: true
  validates :images, presence: true
  validates :images, length: { minimum: 1, maximum: 5, message: "は1枚以上5枚以下にしてください" }
  validates :item_name, presence: true, length: { maximum: 40 }
  validates :item_description, presence: true,length: { maximum: 1000 }
  validates :price, numericality: { only_integer: true, greater_than_or_equal_to: 300, less_than_or_equal_to: 9999999 }

  #ジャンルの選択が「---」の時は保存できないようにする
  validates :item_category_id, numericality: { other_than: 1 , message: "の選択を空白にすることはできません"}
  validates :item_condition_id, numericality: { other_than: 1 , message: "の選択を空白にすることはできません"}
  validates :shipping_cost_id, numericality: { other_than: 1 , message: "の選択を空白にすることはできません"}
  validates :shipping_area_id, numericality: { other_than: 1 , message: "の選択を空白にすることはできません"}
  validates :delivery_time_id, numericality: { other_than: 1 , message: "の選択を空白にすることはできません"}
end

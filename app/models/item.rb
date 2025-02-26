class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :item_category
  belongs_to :item_condition
  belongs_to :shipping_cost
  belongs_to :shipping_area
  belongs_to :delivery_time
  belongs_to :user
  has_one_attached :image

  validates :image, presence: true
  validates :item_name, presence: true
  validates :item_description, presence: true
  validates :price, presence: true

  #ジャンルの選択が「---」の時は保存できないようにする
  validates :item_category_id, numericality: { other_than: 1 , message: "can't be blank"}
  validates :item_condition_id, numericality: { other_than: 1 , message: "can't be blank"}
  validates :shipping_cost_id, numericality: { other_than: 1 , message: "can't be blank"}
  validates :shipping_area_id, numericality: { other_than: 1 , message: "can't be blank"}
  validates :delivery_time_id, numericality: { other_than: 1 , message: "can't be blank"}
end

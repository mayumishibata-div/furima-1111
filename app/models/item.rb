class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :item_category

  #ジャンルの選択が「---」の時は保存できないようにする
  validates :item_category_id, numericality: { other_than: 1 , message: "can't be blank"}
end

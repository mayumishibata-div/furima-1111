require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
  end

  describe '商品出品機能' do
    
    context '商品が出品できる場合' do
      
      it '全てのバリデーションを通過する時' do
        expect(@item).to be_valid
      end

      it "価格の入力が半角数字であること" do
        @item.price = 5000  # ¥5000（半角数字）は有効
        expect(@item).to be_valid
      end

      it "価格が300〜9,999,999の範囲内であること" do
        @item.price = 5000  # ¥5000（半角数字）は有効
        expect(@item).to be_valid
      end

    end

    context '商品が出品できない場合' do

      it '画像が空では出品できないこと' do
        @item.image = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Image can't be blank")
      end

      it '商品名がないと出品できないこと' do
        @item.item_name = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Item name can't be blank")
      end

      it '商品説明がないと出品できないこと' do
        @item.item_description = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Item description can't be blank")
      end
      
      it 'カテゴリが未選択(---)の場合は出品できないこと' do
        @item.item_category_id = 1
        # item = FactoryBot.build(:item, item_category_id: 1)
        @item.valid?
        expect(@item.errors.full_messages).to include("Item category can't be blank")
      end

      it '商品の状態が未選択(---)の場合は出品できないこと' do
        @item.item_condition_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Item condition can't be blank")
      end

      it '送料が未選択(---)の場合は出品できないこと' do
        @item.shipping_cost_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Shipping cost can't be blank")
      end

      it '配送料地域が未選択(---)の場合は出品できないこと' do
        @item.shipping_area_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Shipping area can't be blank")
      end

      it '配送時間が未選択(---)の場合は出品できないこと' do
        @item.delivery_time_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Delivery time can't be blank")
      end

      it '価格が入力されていないと出品できないこと' do
        @item.price = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Price is not a number")
      end

      it "価格が全角数字で入力されていると出品できないこと" do
        @item.price = ("５０００")  # 全角数字は無効
        @item.valid?
        expect(@item.errors.full_messages).to include("Price is not a number")
      end

      it "価格が300円以下だったら出品できないこと" do
        @item.price = 200
        @item.valid?
        expect(@item.errors.full_messages).to include("Price must be greater than or equal to 300")
      end

      it "価格が9,999,999以上だったら出品できないこと" do
        @item.price = 10000000
        @item.valid?
        expect(@item.errors.full_messages).to include("Price must be less than or equal to 9999999")
      end
      
      it "userと紐づいていないと出品できないこと" do
        @item.user = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("User must exist")
      end
      
    end
  end
end

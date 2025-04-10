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

      it "価格が300円〜9,999,999円の範囲内であること" do
        @item.price = 5000  # ¥5000（半角数字）は有効
        expect(@item).to be_valid
      end

    end

    context '商品が出品できない場合' do

      it '画像が空では出品できないこと（1枚以上 5枚以下の画像投稿が可能）' do
        @item.images = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("商品画像は1枚以上5枚以下にしてください")
      end

      it '商品名がないと出品できないこと' do
        @item.item_name = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("商品名を入力してください")
      end

      it '商品説明がないと出品できないこと' do
        @item.item_description = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("商品の説明を入力してください")
      end
      
      it 'カテゴリが未選択(---)の場合は出品できないこと' do
        @item.ancestry = nil
        # item = FactoryBot.build(:item, item_category_id: 1)
        @item.valid?
        expect(@item.errors.full_messages).to include("Ancestryを入力してください")
      end

      it '商品の状態が未選択(---)の場合は出品できないこと' do
        @item.item_condition_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("商品の状態の選択を空白にすることはできません")
      end

      it '配送料の負担が未選択(---)の場合は出品できないこと' do
        @item.shipping_cost_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("配送料の負担の選択を空白にすることはできません")
      end

      it '発送元の地域が未選択(---)の場合は出品できないこと' do
        @item.shipping_area_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("発送元の地域の選択を空白にすることはできません")
      end

      it '発送までの日数が未選択(---)の場合は出品できないこと' do
        @item.delivery_time_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("発送までの日数の選択を空白にすることはできません")
      end

      it '価格が入力されていないと出品できないこと' do
        @item.price = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("販売価格は数値で入力してください")
      end

      it "価格が全角数字で入力されていると出品できないこと" do
        @item.price = ("５０００")  # 全角数字は無効
        @item.valid?
        expect(@item.errors.full_messages).to include("販売価格は数値で入力してください")
      end

      it "価格が300円以下だったら出品できないこと" do
        @item.price = 200
        @item.valid?
        expect(@item.errors.full_messages).to include("販売価格は300以上の値にしてください")
      end

      it "価格が9,999,999円以上だったら出品できないこと" do
        @item.price = 10000000
        @item.valid?
        expect(@item.errors.full_messages).to include("販売価格は9999999以下の値にしてください")
      end
      
      it "ユーザーと紐づいていないと出品できないこと" do
        @item.user = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Userを入力してください")
      end

    end
  end
end

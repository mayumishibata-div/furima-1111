require 'rails_helper'

RSpec.describe OrderShippingAddress, type: :model do
  before do
    user = FactoryBot.create(:user)
    item = FactoryBot.create(:item)
    @order_shipping_address = FactoryBot.build(:order_shipping_address, user_id: user.id, item_id: item.id)
  end
  describe '購入情報の保存' do

    context '内容に問題ない場合' do
      it 'すべての値が正しく入力されていれば保存できること' do
        expect(@order_shipping_address).to be_valid
      end

      it '建物名は空でも保存できること' do
        @order_shipping_address.building_name = ''
        expect(@order_shipping_address).to be_valid
      end

      it 'クレジットカード情報があれば保存ができること' do
        @order_shipping_address.token = '123'
        expect(@order_shipping_address).to be_valid
      end
    end

    context '内容に問題がある場合' do
      it '郵便番号が空だと保存できないこと' do
        @order_shipping_address.post_code = ''
        @order_shipping_address.valid?
        expect(@order_shipping_address.errors.full_messages).to include("郵便番号を入力してください")
      end

      it '郵便番号が半角のハイフンを含んだ正しい形式でないと保存できないこと' do
        @order_shipping_address.post_code = '1234567'
        @order_shipping_address.valid?
        expect(@order_shipping_address.errors.full_messages).to include("郵便番号は「XXX-XXXX」の形式で入力してください")
      end

      it '都道府県を選択していないと保存できないこと' do
        @order_shipping_address.shipping_area_id = 1
        @order_shipping_address.valid?
        expect(@order_shipping_address.errors.full_messages).to include("都道府県の選択を空白にすることはできません")
      end

      it '市町村が空だと保存できないこと' do
        @order_shipping_address.city = ''
        @order_shipping_address.valid?
        expect(@order_shipping_address.errors.full_messages).to include("市区町村を入力してください")
      end

      it '番地が空だと保存できないこと' do
        @order_shipping_address.address = ''
        @order_shipping_address.valid?
        expect(@order_shipping_address.errors.full_messages).to include("番地を入力してください")
      end

      it '電話番号が空だと保存できないこと' do
        @order_shipping_address.tel_number = ''
        @order_shipping_address.valid?
        expect(@order_shipping_address.errors.full_messages).to include("電話番号を入力してください")
      end

      it '電話番号が全角数字だと保存できないこと' do
        @order_shipping_address.tel_number = '１２３４５'
        @order_shipping_address.valid?
        expect(@order_shipping_address.errors.full_messages).to include("電話番号は10桁以上11桁以内の半角数値で入力してください")
      end

      it '電話番号は10桁以下だと保存できないこと' do
        @order_shipping_address.tel_number = '12345'
        @order_shipping_address.valid?
        expect(@order_shipping_address.errors.full_messages).to include("電話番号は10桁以上11桁以内の半角数値で入力してください")
      end

      it '電話番号は11桁以上だと保存できないこと' do
        @order_shipping_address.tel_number = '1234567891011'
        @order_shipping_address.valid?
        expect(@order_shipping_address.errors.full_messages).to include("電話番号は10桁以上11桁以内の半角数値で入力してください")
      end

      it 'ユーザーが紐付いていないと保存できないこと' do
        @order_shipping_address.user_id = nil
        @order_shipping_address.valid?
        expect(@order_shipping_address.errors.full_messages).to include("Userを入力してください")
      end

      it '商品が紐づいていないと保存できないこと' do
        @order_shipping_address.item_id = nil
        @order_shipping_address.valid?
        expect(@order_shipping_address.errors.full_messages).to include("Itemを入力してください")
      end

      it "クレジットカード情報が空では登録できないこと" do
        @order_shipping_address.token = nil
        @order_shipping_address.valid?
        expect(@order_shipping_address.errors.full_messages).to include("クレジットカード情報を入力してください")
      end
    end
  end
end
require 'rails_helper'

RSpec.describe OrderShippingAddress, type: :model do
  before do
    user = FactoryBot.create(:user)
    @order_shipping_address = FactoryBot.build(:order_shipping_address, user_id: user.id)
  end
  describe '購入情報の保存' do

    context '内容に問題ない場合' do
      it 'すべての値が正しく入力されていれば保存できること' do
        expect(@order_shipping_address).to be_valid
      end

      it 'building_nameは空でも保存できること' do
        @order_shipping_address.building_name = ''
        expect(@order_shipping_address).to be_valid
      end
    end

    context '内容に問題がある場合' do
      it 'post_codeが空だと保存できないこと' do
        @order_shipping_address.post_code = ''
        @order_shipping_address.valid?
        expect(@order_shipping_address.errors.full_messages).to include("Post code can't be blank")
      end

      it 'post_codeが半角のハイフンを含んだ正しい形式でないと保存できないこと' do
        @order_shipping_address.post_code = '1234567'
        @order_shipping_address.valid?
        expect(@order_shipping_address.errors.full_messages).to include('Post code は「XXX-XXXX」の形式で入力してください')
      end

      it 'shipping_areaを選択していないと保存できないこと' do
        @order_shipping_address.shipping_area_id = 1
        @order_shipping_address.valid?
        expect(@order_shipping_address.errors.full_messages).to include("Shipping area can't be blank")
      end

      it 'cityが空だと保存できないこと' do
        @order_shipping_address.city = ''
        @order_shipping_address.valid?
        expect(@order_shipping_address.errors.full_messages).to include("City can't be blank")
      end

      it 'addressが空だと保存できないこと' do
        @order_shipping_address.address = ''
        @order_shipping_address.valid?
        expect(@order_shipping_address.errors.full_messages).to include("Address can't be blank")
      end

      it 'tel_numberが空だと保存できないこと' do
        @order_shipping_address.tel_number = ''
        @order_shipping_address.valid?
        expect(@order_shipping_address.errors.full_messages).to include("Tel number can't be blank")
      end

      it 'tel_numberが全角数字だと保存できないこと' do
        @order_shipping_address.tel_number = '１２３４５'
        @order_shipping_address.valid?
        expect(@order_shipping_address.errors.full_messages).to include("Tel number は10桁以上11桁以内の半角数値で入力してください")
      end

      it 'Tel_number は10桁以下だと保存できないこと' do
        @order_shipping_address.tel_number = '12345'
        @order_shipping_address.valid?
        expect(@order_shipping_address.errors.full_messages).to include("Tel number は10桁以上11桁以内の半角数値で入力してください")
      end

      it 'Tel_number は11桁以上だと保存できないこと' do
        @order_shipping_address.tel_number = '1234567891011'
        @order_shipping_address.valid?
        expect(@order_shipping_address.errors.full_messages).to include("Tel number は10桁以上11桁以内の半角数値で入力してください")
      end

      it 'userが紐付いていないと保存できないこと' do
        @order_shipping_address.user_id = nil
        @order_shipping_address.valid?
        expect(@order_shipping_address.errors.full_messages).to include("User can't be blank")
      end
    end
  end
end
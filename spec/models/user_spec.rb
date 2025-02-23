require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do

    context '新規登録できる場合' do

      it "nicknameとemail、passwordとpassword_confirmation、last_name、
          first_name、last_name_kana、first_name_kana、birthdayが存在すれば登録できる" do
        expect(@user).to be_valid
      end
      
      it 'first_nameが全角ひらがな、全角カタカナ、全角漢字の場合は登録できる' do
        valid_names = ['まゆみ', 'マユミ', '真由美']
        valid_names.each do |name|
          @user.first_name = name
          expect(@user).to be_valid
        end
      end
      
      it 'last_nameが全角ひらがな、全角カタカナ、全角漢字の場合は登録できる' do
        valid_names = ['まゆみ', 'マユミ', '真由美']
        valid_names.each do |name|
          @user.first_name = name
          expect(@user).to be_valid
        end
      end

      it 'first_name_kanaが全角カタカナの場合は登録できる' do
        @user.first_name_kana = 'マユミ' 
        expect(@user).to be_valid 
      end

      it 'last_name_kanaが全角カタカナの場合は登録できる' do
        @user.last_name_kana = 'マユミ' 
        expect(@user).to be_valid 
      end
    end

    context '新規登録できない場合' do

      it "nicknameが空では登録できない" do
        @user.nickname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Nickname can't be blank")
      end

      it "emailが空では登録できない" do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end

      it '重複したemailが存在する場合は登録できない' do
        @user.save
        another_user = FactoryBot.build(:user, email: @user.email)
        another_user.valid?
        expect(another_user.errors.full_messages).to include('Email has already been taken')
      end

      it 'emailは@を含まないと登録できない' do
        @user.email = 'testmail'
        @user.valid?
        expect(@user.errors.full_messages).to include('Email is invalid')
      end

      it "passwordが空では登録できない" do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end

      it 'passwordとpassword_confirmationが不一致では登録できない' do
        @user.password = '123456'
        @user.password_confirmation = '1234567'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end

      it "passwordは英字だけでは登録できない" do
        @user.password = 'abcdef'
        @user.password_confirmation = "abcdef"
        @user.valid?
        expect(@user.errors.full_messages).to include("Password には英字と数字の両方を含めて設定してください")
      end

      it "passwordは数字だけでは登録できない" do
        @user.password = '123456'
        @user.password_confirmation = "123456"
        @user.valid?
        expect(@user.errors.full_messages).to include("Password には英字と数字の両方を含めて設定してください")
      end

      it "passwordに全角文字が含まれていると登録できない" do
        @user.password = 'abc123'   # 半角
        @user.password += 'あいう'   # 全角文字を追加
        @user.password_confirmation = @user.password
        @user.valid?
        expect(@user.errors.full_messages).to include("Password には英字と数字の両方を含めて設定してください")
      end
      
      it "passwordが6文字以上でないと登録できない" do
        @user.password = '12345'
        @user.password_confirmation = "12345"
        @user.valid?
        expect(@user.errors.full_messages).to include("Password は6文字以上で設定してください")
      end

      it "first_nameが空では登録できない" do
        @user.first_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("First name can't be blank")
      end

      it 'first_nameが半角英数字、半角カタカナでは登録できない' do
        invalid_names = ['mayumi1111', 'ﾏﾕﾐ']
        invalid_names.each do |name|
          @user.first_name = name
          @user.valid?
          expect(@user.errors.full_messages).to include("First name 全角文字を使用してください")
        end
      end

      it "last_nameが空では登録できない" do
        @user.last_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name can't be blank")
      end

      it 'last_nameが半角英数字、半角カタカナでは登録できない' do
        invalid_names = ['mayumi1111', 'ﾏﾕﾐ']
        invalid_names.each do |name|
          @user.last_name = name
          @user.valid?
          expect(@user.errors.full_messages).to include("Last name 全角文字を使用してください")
        end
      end

      it "first_name_kanaが空では登録できない" do
        @user.first_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("First name kana can't be blank")
      end

      it 'first_name_kanaが全角では登録できない' do
        @user.first_name_kana = 'まゆみマユミ'
        @user.valid?
        expect(@user.errors.full_messages).to include("First name kana 半角カタカナを使用してください")
      end

      it "last_name_kanaが空では登録できない" do
        @user.last_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name kana can't be blank")
      end

      it 'last_name_kanaが全角では登録できない' do
        @user.last_name_kana = 'まゆみマユミ'
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name kana 半角カタカナを使用してください")
      end

      it "birthdayが空では登録できない" do
        @user.birthday = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Birthday can't be blank")
      end
    end
  end
end

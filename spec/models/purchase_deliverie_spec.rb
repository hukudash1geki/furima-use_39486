require 'rails_helper'

RSpec.describe PurchaseDeliverie, type: :model do
  describe '配送情報の保存' do
    before do
      item = FactoryBot.create(:item)
      user = FactoryBot.create(:user)
      @purchase_deliverie = FactoryBot.build(:purchase_deliverie, user_id: user.id, item_id: item.id)
    end

    context '内容に問題ない場合' do
      it 'すべての値が正しく入力されていれば保存できること' do
        expect(@purchase_deliverie).to be_valid
      end
      it 'building_nameは空でも保存できること' do
        @purchase_deliverie.building_name = ''
        expect(@purchase_deliverie).to be_valid
      end
    end

    context '内容に問題がある場合' do
      it 'tokenが空では登録できないこと' do
        @purchase_deliverie.token = nil
        @purchase_deliverie.valid?
        expect(@purchase_deliverie.errors.full_messages).to include("Token can't be blank")
      end
      it 'postal_codeが空だと保存できないこと' do
        @purchase_deliverie.postal_code = ''
        @purchase_deliverie.valid?
        expect(@purchase_deliverie.errors.full_messages).to include("Postal code can't be blank")
      end
      it 'postal_codeが半角のハイフンを含んだ正しい形式でないと保存できないこと' do
        @purchase_deliverie.postal_code = '1234567'
        @purchase_deliverie.valid?
        expect(@purchase_deliverie.errors.full_messages).to include('Postal code is invalid. Enter it as follows (e.g. 123-4567)')
      end
      it 'prefectureを選択していないと保存できないこと' do
        @purchase_deliverie.prefecture_id = 0
        @purchase_deliverie.valid?
        expect(@purchase_deliverie.errors.full_messages).to include("Prefecture can't be blank")
      end
      it 'cities_and_townsが空だと保存できないこと' do
        @purchase_deliverie.cities_and_towns = nil
        @purchase_deliverie.valid?
        expect(@purchase_deliverie.errors.full_messages).to include("Cities and towns can't be blank")
      end
      it 'house_numberが空だと保存できないこと' do
        @purchase_deliverie.house_number = nil
        @purchase_deliverie.valid?
        expect(@purchase_deliverie.errors.full_messages).to include("House number can't be blank")
      end
      it 'telephone_numberが空だと保存できないこと' do
        @purchase_deliverie.telephone_number = nil
        @purchase_deliverie.valid?
        expect(@purchase_deliverie.errors.full_messages).to include("Telephone number can't be blank")
      end
      it 'telephone_numberが11文字以下なら保存できないこと' do
        @purchase_deliverie.telephone_number = '1234567'
        @purchase_deliverie.valid?
        expect(@purchase_deliverie.errors.full_messages).to include('Telephone number is too short')
      end
      it 'telephone_numberが数字のみでないと保存できないこと' do
        @purchase_deliverie.telephone_number = '123-4567-89'
        @purchase_deliverie.valid?
        expect(@purchase_deliverie.errors.full_messages).to include('Telephone number is invalid. Input only number')
      end
      it 'userが紐付いていないと保存できないこと' do
        @purchase_deliverie.user_id = nil
        @purchase_deliverie.valid?
        expect(@purchase_deliverie.errors.full_messages).to include("User can't be blank")
      end
      it 'itemが紐付いていないと保存できないこと' do
        @purchase_deliverie.item_id = nil
        @purchase_deliverie.valid?
        expect(@purchase_deliverie.errors.full_messages).to include("Item can't be blank")
      end
    end
  end
end

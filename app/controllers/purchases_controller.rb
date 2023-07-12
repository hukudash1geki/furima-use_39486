class PurchasesController < ApplicationController
  before_action :set_public_key, only: [:index, :create]
  def index
    @item = Item.find(params[:item_id])
    @purchase_deliverie = PurchaseDeliverie.new
  end

  def create
    @item = Item.find(params[:item_id])
    @purchase_deliverie = PurchaseDeliverie.new(purchase_params)
    if @purchase_deliverie.valid?
      pay_item
       @purchase_deliverie.save
       redirect_to root_path
    else
      @item = Item.find(params[:item_id])
      render :index, status: :unprocessable_entity
    end
  end

  private

  def purchase_params
    params.require(:purchase_deliverie).permit(:postal_code, :prefecture_id, :cities_and_towns, :house_number, :building_name, :telephone_number, :token).merge(user_id: current_user.id, item_id: params[:item_id], token: params[:token])
  end

  def pay_item
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
      Payjp::Charge.create(
        amount: @item[:price],  
        card: purchase_params[:token],    
        currency: 'jpy'                 
    )
  end

  def set_public_key
    gon.public_key = ENV["PAYJP_PUBLIC_KEY"]
  end

end


class PurchasesController < ApplicationController
  before_action :set_public_key, only: [:index, :create]
  before_action :move_to_log_in
  before_action :move_to_index
  before_action :move_to_top
  def index
    @purchase_deliverie = PurchaseDeliverie.new
  end

  def create
    @purchase_deliverie = PurchaseDeliverie.new(purchase_params)
    if @purchase_deliverie.valid?
      pay_item
      @purchase_deliverie.save
      redirect_to root_path
    else
      render :index, status: :unprocessable_entity
    end
  end

  private

  def purchase_params
    params.require(:purchase_deliverie).permit(:postal_code, :prefecture_id, :cities_and_towns, :house_number, :building_name, :telephone_number, :token).merge(
      user_id: current_user.id, item_id: params[:item_id], token: params[:token]
    )
  end

  def move_to_log_in
    return if user_signed_in?

    redirect_to user_session_path
  end

  def move_to_index
    @item = Item.find(params[:item_id])
    @purchase = Purchase.all
    return unless @item.purchase.present?

    redirect_to '/'
  end

  def move_to_top
    @item = Item.find(params[:item_id])
    return unless current_user.id == @item.user_id

    redirect_to '/'
  end

  def pay_item
    Payjp.api_key = ENV['PAYJP_SECRET_KEY']
    Payjp::Charge.create(
      amount: @item[:price],
      card: purchase_params[:token],
      currency: 'jpy'
    )
  end

  def set_public_key
    gon.public_key = ENV['PAYJP_PUBLIC_KEY']
  end
end

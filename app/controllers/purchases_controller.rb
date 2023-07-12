class PurchasesController < ApplicationController

  def new
    @items = Item.all
    @item = Item.find(params[:item_id])
    @purchase_deliverie = PurchaseDeliverie.new(user_id: current_user.id, item_id: @item.id)
  end

  def create
    @purchase_deliverie = PurchaseDeliverie.new(purchase_params)
    if @purchase_deliverie.valid?
       @purchase_deliverie.save
       redirect_to root_path
    else
      @items = Item.all
      render :new, status: :unprocessable_entity
    end
  end

  private

  def purchase_params
    params.require(:purchase_deliverie).permit(:postal_code, :prefecture_id, :cities_and_towns, :house_number, :building_name, :telephone_number, :token).merge(user_id: current_user.id, item_id: params[:item_id])
  end

end


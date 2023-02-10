class Admin::ItemsController < ApplicationController
  def index
    @items = Item.page(params[:page]).per(10)   # kaminari install
  end

  def new
    @item = Item.new
  end

  def show
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      flash[:notice] = "商品の新規登録が完了しました。"
      redirect_to admin_item_path(@item)
    else
      flash[:alert] = "商品の新規登録内容に不備があります。"
      render :new
    end
  end

  def edit
  end

    private

  def item_params
    params.require(:item).permit(:items, :genre_id, :name, :introduction, :price, :is_active, :image)
  end

end
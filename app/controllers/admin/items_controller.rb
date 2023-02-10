class Admin::ItemsController < ApplicationController
  def index
    @items = Item.page(params[:page]).per(10)   # kaminari install
  end

  def new
  end

  def show
  end

  def edit
  end
end

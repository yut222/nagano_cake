class Public::ItemsController < ApplicationController
  def index
    @items = Item.page(params[:page]).per(8)
    @items_all = Item.all
    @genres = Genre.all
  end

  def show
  end

  # ジャンル検索機能
  def sidebar
    @items = Item.where(genre_id: params[:format]).page(params[:page]).per(8) # パラメーターで渡ってきたジャンルidを元に、Item内のgenre_idと完全一致する商品情報を取得している。
    @amount = Item.where(genre_id: params[:format]).count # 検索してきたジャンルの商品数をカウント
    @genres = Genre.where(valid_invalid_status: 0)
    render 'index' # renderを使用してviewファイルを表示したときにはactionを呼び出し処理をしているわけではないため、上記のように必要な変数を用意しておく必要がある、
  end

end

class Admin::GenresController < ApplicationController
  def index
    @genres = Genre.page(params[:page]).per(10)
    @genre = Genre.new
  end

  def create
    @genre = Genre.new(genre_params)
    if @genre.save
       flash[:notice] = "ジャンルを追加しました"
       redirect_to admin_genres_path
    else
      @genres = Genre.all.page(params[:page]).per(10)
      render :index and return
    end
  end

  def edit
  end

    private

  def genre_params
    params.require(:genre).permit(:name)
  end

end
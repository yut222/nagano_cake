class Admin::GenresController < ApplicationController
  def index
    @genres = Genre.page(params[:page]).per(8)
    @genre = Genre.new
  end

  def edit
  end
end

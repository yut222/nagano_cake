class ApplicationController < ActionController::Base

  before_action :authenticate_admin!

  def top
  end

end
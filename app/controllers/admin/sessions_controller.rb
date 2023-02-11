# frozen_string_literal: true

class Admin::SessionsController < Devise::SessionsController

  # devise機能/sign_in時の遷移先指定:管理者トップページ
  def after_sign_in_path_for(resource)
    admin_root_path
  end

  # devise機能/sign_out時の遷移先指定
  def after_sign_out_path_for(resource)
    new_admin_session_path
  end


  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end

class ApplicationController < ActionController::Base

  before_action :configure_permitted_parameters, if: :devise_controller?  # ログインユーザーによってのみ実行可能

  protected

    # 新規登録の保存機能
    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up,
          keys: [:first_name, :last_name, :kana_first_name, :kana_last_name,
                :email, :postal_code, :address, :telephone_number])

      #sign_upの際にnameのデータ操作を許可。追加したカラム。
      devise_parameter_sanitizer.permit(:sign_in, keys: [:email])
    end

  private

    # before_action作成  # ログインユーザーによってのみ実行可能
    def item
      @ietm = Item.find(params[:id])
    end

    def customer
      @customer = Customer.find(params[:id])
    end

    def cart_item
      @cart_item = CartItem.find(params[:id])
    end

end
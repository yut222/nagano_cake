class ApplicationController < ActionController::Base

  before_action :configure_permitted_parameters, if: :devise_controller?  # ログインユーザーによってのみ実行可能

  protected

    # ログイン時のパスを変更してる
    #def after_sign_in_path_for(resource_or_scope)
      #if resource_or_scope.is_a?(Admin)
        #admin_items_path(resource)  # 管理者側
      #else
        #items_path  # 顧客側
      #end
   # end

    #ログアウト時のパスの変更
    #    def after_sign_out_path_for(resource_or_scope)
    #      if resource_or_scope == :admin
    #       new_admin_session_path  # 管理者側
    #      else
    #       admin_session_path  # 顧客側
     #     end
    #    end


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
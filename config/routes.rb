Rails.application.routes.draw do

  namespace :admin do
    root to: 'homes#top'
  end

  root 'public/homes#top'


  # 顧客側
  scope module: :public do
    # 商品
    resources :items, only: [:index, :show]
    # 会員
    resource :customers, only: [:show, :edit, :update, :quit, :out]
    post "/orders/confirm" => "orders#confirm"
    get "/orders/thanks" => "orders#thanks"
    # カート
    delete "/cart_items/all_destroy" => "cart_items#all_destroy"
    resources :cart_items, only: [:index, :create, :update, :destroy, :all_destroy]
    # 注文
    resources :orders, only: [:new, :confirm, :thanks, :create, :index, :show]

    # 登録先住所
    resources :addresses, only: [:index, :edi, :createt, :update, :destroy]
    get "/customers/quit" => "customers#quit"
    patch "/customers/out" => "customers#out"

    get "/about" => "homes#about"
    get "/search" => "items#search"
  end


  # 管理者
  namespace :admin do

    # 商品
    resources :items, only: [:index, :new, :create, :show, :edit, :update]
    # ジャンル
    resources :genres, only: [:index, :create, :edit, :update]
    # 会員
    resources :customers, only: [:index, :show, :edit, :update]
    # 注文
    resources :orders, only: [:show, :update]
    get "/" => "homes#top"
    # 制作
    resources :order_details, only: [:update]
  end

  # 顧客用
  # URL /customers/sign_in ...
  # パスワード変更は不要なため、skip
  devise_for :customers,skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  # 管理者用
  # URL /admin/sign_in ...
  # 登録,パスワード変更は不要なため、skip
  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
    sessions: "admin/sessions"
  }


  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

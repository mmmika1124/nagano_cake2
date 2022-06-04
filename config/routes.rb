Rails.application.routes.draw do
  # 顧客用
  scope module: 'public' do
    root to: 'homes#top'
    get 'about' => 'homes#about'
  end

  scope module: 'public' do
    get 'customers/mypage' => 'customers#show'
    get 'customers/edit'
    get 'customers/unsubscribe'
    patch 'customers/withdraw' => 'customers#withdraw'
    resources :customers, only: [:update]
  end

  scope module: 'public' do
    resources :items, only:[:index, :show]
  end

  scope module: 'public' do
    resources :addresses, only:[:index, :edit, :create, :update, :destroy]
  end

  scope module: 'public' do
    resources :addresses, only:[:index, :create, :update, :destroy]
    delete 'cart_items/destroy_all' => 'cart_items#destroy_all'
  end

  # 管理者用
  namespace :admin do
    get '/' => 'homes#top'
  end

  namespace :admin do
    get '/' => 'homes#top'
    resources :genres, only:[:index, :create, :edit, :update]
  end

  namespace :admin do
    resources :items, only:[:index, :new, :create, :show, :edit, :update]
  end

  namespace :admin do
    resources :customers, only:[:index, :show, :edit, :update]
  end

  # 顧客用
  devise_for :customers,skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }
  # 管理者用
  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
    sessions: "admin/sessions"
  }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

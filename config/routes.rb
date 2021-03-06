Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations',
  }
  devise_scope :user do
    get 'addresses', to: 'users/registrations#new_address'
    post 'addresses', to: 'users/registrations#create_address'
  end

  root to: 'items#index'

  resources :items do
    collection do
      get "set_parents"
      get "set_children"
      get "set_grandchildren"
      get "set_images"
      get "detail"
      get "list"
    end

    member do
      get "purchase"
      post "pay"
      patch "done"
    end
  end

  resources :users, only: [:new, :edit, :show, :update] do
    collection do
      get "touroku"
    end
  end

  resources :mypage, only: [:index, :show, :new, :edit, :create] do
    collection do
      get "logout"
      get "card"
    end
  end

  resources :creditcards, only:[:index, :new, :create, :destroy, :show] do
    member do
      post 'pay'
    end
  end

end

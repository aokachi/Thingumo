Rails.application.routes.draw do
  devise_for :users, controllers: { sessions: 'sessions', registrations: 'registrations' }

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'toppages#index'
  
  get 'signup', to: 'users#new'
  post 'signup', to: 'users#create'

  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  resources :users, except: [:index, :new]
  resources :posts, except: [:index]
  resources :categories, only: [:index]

  resources :posts do
    resources :comments, only:[:create, :destroy]
  end

  # 問い合わせ機能
  resources :inquiries, only: [:new, :create]
end

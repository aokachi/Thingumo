Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'toppages#index'
  
  get 'signup', to: 'users#new'
  post 'signup', to: 'users#create'

  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  # 問い合わせページ
  get 'inquiries/new'
  # 問い合わせの送信完了ページ
  get 'inquiries/thanks'

  resources :users, except: [:index, :new]
  resources :posts, except: [:index]
  resources :categories, only: [:index]

  resources :posts do
    resources :comments, only:[:create, :destroy]
  end

  # 問い合わせページ
  resources :inquiries do
    # 問い合わせへの返信送信用
    post 'create_reply', on: :member
  end
end

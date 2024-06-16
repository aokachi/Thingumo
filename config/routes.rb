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
    resources :answers, only:[:create, :destroy]
  end

  # 問い合わせ機能
  resources :inquiries, only: [:new, :create]

  # 回答機能
  resources :answers, only: [] do
    resources :answers, only: [:create, :destroy], module: :answers
  end

  # 正解を選択
  post '/answers/confirm', to: 'answers#confirm'

  # 回答の入力チェック機能
  post '/answers/check', to: 'answers#check_answer'

  # プライバシーポリシーを表示する
  get 'privacy_policy', to: 'privacy_policies#show'

  # 利用規約を表示する
  get 'term_of_service', to: 'terms_of_service#show'
end
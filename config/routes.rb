Rails.application.routes.draw do
  devise_for :users, controllers: { sessions: 'sessions', registrations: 'registrations' }

  root to: 'toppages#index'
  
  get 'signup', to: 'users#new'
  post 'signup', to: 'users#create'

  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  resources :users, except: [:index, :new]
  resources :categories, only: [:index]

  resources :posts, except: [:index] do
    resources :answers, only: [:create, :destroy] do
      member do
        post 'confirm'
      end
    end
  end

  # 問い合わせ機能
  resources :inquiries, only: [:new, :create]

  # 保留中回答一覧確認画面
  get 'pending_answers', to: 'answers#pending', as: 'pending_answers'

  # 保留中の回答を承認する
  patch '/answers/:id/approve', to: 'answers#approve', as: 'approve_answer'
end
Rails.application.routes.draw do
  get 'static_pages/privacy_policy'
  get 'static_pages/term_of_service'
  devise_for :users, controllers: { sessions: 'sessions', registrations: 'registrations' }

  root to: 'toppages#index'
  
  # カテゴリ選択時
  get 'toppages', to: 'toppages#index'

  get 'signup', to: 'users#new'
  post 'signup', to: 'users#create'

  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  resources :users, except: [:index, :new]
  resources :categories, only: [:index]

  resources :questions, except: [:index] do
    resources :answers, only: [:create, :destroy] do
      member do
        post 'confirm'
      end
    end
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

  # 保留中回答一覧確認画面
  get 'pending_answers', to: 'answers#pending', as: 'pending_answers'

  # 保留中の回答を承認する
  patch '/answers/:id/approve', to: 'answers#approve', as: 'approve_answer'

  # プライバシーポリシーを表示する
  get 'privacy_policy', to: 'static_pages#privacy_policy'

  # 利用規約を表示する
  get 'term_of_service', to: 'static_pages#term_of_service'
end
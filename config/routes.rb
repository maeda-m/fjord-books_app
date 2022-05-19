Rails.application.routes.draw do
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
  devise_for :users
  root to: 'books#index'
  concern :commentable do |options|
    scope options do
      resources :comments, only: %i[create edit update destroy]
    end
  end
  resources :books do
    concerns(:commentable, module: :books)
  end
  resources :reports do
    concerns(:commentable, module: :reports)
  end
  resources :users, only: %i[index show] do
    resource :relationships, only: %i[create destroy]
    scope module: :users do
      resources :followings, only: [:index]
      resources :followers, only: [:index]
    end
  end
end

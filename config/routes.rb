Rails.application.routes.draw do
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
  devise_for :users
  root to: 'books#index'
  resources :books
  resources :users, only: %i(index show) do
    resources :followings, only: %i(index create), controller: 'users/followings' do
      delete :destroy, on: :collection
    end
    resources :followers, only: %i(index), controller: 'users/followers'
  end
end

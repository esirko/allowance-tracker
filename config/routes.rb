Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :accounts do
    resources :transactions
    resources :incrementors
  end

#  resources :users
#  resource :user_session

  #resource :account, :controller => "users"
  #resources :users
  resource :user_session
  #root :controller => "user_sessions", :action => "new"
  root "accounts#index"

  #resources :user_sessions, only: [:create, :destroy]
  delete '/sign_out', to: 'user_sessions#destroy', as: :sign_out
  get '/sign_in', to: 'user_sessions#new', as: :sign_in
end

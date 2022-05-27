Rails.application.routes.draw do
  resources :stocks
  get '/current_user', to: 'current_user#index'
  devise_for :users, controllers: { confirmations: 'confirmations' }, path: '', path_names: {
    sign_in: 'login',
    sign_out: 'logout',
    registration: 'signup'
  },
  controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }
  resources :wallets do
    resources :transactions
  end
end

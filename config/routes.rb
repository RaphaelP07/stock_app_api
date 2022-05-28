Rails.application.routes.draw do
  get '/stocks/top_ten' => 'stocks#top_ten', as: 'top_ten'
  get '/stocks/info/:symbol' => 'stocks#info', as: 'info'
  post '/wallets/:wallet_id/transactions/buy/:symbol/:shares' => 'transactions#buy', as: 'buy'
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

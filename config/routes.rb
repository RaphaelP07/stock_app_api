Rails.application.routes.draw do
  get '/stocks/top_ten' => 'stocks#top_ten', as: 'top_ten'
  get '/stocks/info/:symbol' => 'stocks#info', as: 'info'
  get '/wallets/:wallet_id/portfolio' => 'transactions#portfolio', as: 'portfolio'
  post '/wallets/:wallet_id/transactions/buy/:symbol/:shares' => 'transactions#buy', as: 'buy'
  post '/wallets/:wallet_id/transactions/sell/:symbol/:shares' => 'transactions#sell', as: 'sell'
  post '/wallets/:id/cash-in/:amount' => 'wallets#cash_in', as: 'cash_in'
  post '/wallets/:id/cash-out/:amount' => 'wallets#cash_out', as: 'cash_out'
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

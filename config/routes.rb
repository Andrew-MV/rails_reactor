Rails.application.routes.draw do

  scope 'api' do
    post '/analyze', to: 'application#analyze'
    post '/correlate', to: 'application#correlate'
    post '/sign-up', to: 'authorization#sign_up'
    post '/sign-in', to: 'authorization#sign_in'
    post '/log-out', to: 'authorization#log_out'
    post '/verify-token', to: 'authorization#verify_token'
  end

  root 'application#index'
  get '*path' => 'application#index'

end
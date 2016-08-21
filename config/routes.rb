Rails.application.routes.draw do

  scope 'api' do
    post '/analyze', to: 'application#analyze'
    post '/correlate', to: 'application#correlate'
    post '/sign-up', to: 'authorization#sign_up'
    post '/sign-in', to: 'authorization#sign_in'
  end

  root 'application#index'
  get '*path' => 'application#index'

end
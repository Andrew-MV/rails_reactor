Rails.application.routes.draw do

  scope 'api' do
    post '/analyze', to: 'application#analyze'
    post '/correlate', to: 'application#correlate'
  end

  root 'application#index'
  get '*path' => 'application#index'

end
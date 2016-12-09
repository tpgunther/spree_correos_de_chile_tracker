Spree::Core::Engine.routes.draw do
  # Add your extension routes here
  # get '/tracking/:number', to: 'trackings#show', as: :tracking

  resources :tracking, only: [:show], param: :number
end

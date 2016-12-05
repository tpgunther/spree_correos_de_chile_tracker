Spree::Core::Engine.routes.draw do
  # Add your extension routes here
  resources :tracking, only: [:show]
end

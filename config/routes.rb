Rails.application.routes.draw do
  resources :players
  get '/health', to: 'health#health' 
end

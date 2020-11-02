Rails.application.routes.draw do
  
  root "pages#home"  
  get 'pages/home', to: 'pages#home'
  
  get '/pictures', to: 'pictures#index'
  get 'pictures/:id', to: 'pictures#show', as: 'picture'


end

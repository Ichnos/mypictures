Rails.application.routes.draw do
  
  root "pages#home"  
  get 'pages/home', to: 'pages#home'
  resources :pictures
  
  get '/signup', to: 'users#new'
  resources :users, except: [:new]
 

end

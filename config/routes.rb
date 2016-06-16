Rails.application.routes.draw do

  root                        'vcms#home'
  get     'login'         =>  'sessions#new'
  post    'login'         =>  'sessions#create'
  delete  'logout'        =>  'sessions#destroy'

  resources :employee_notes
  resources :shift_notes
  resources :users
  resources :permissions
  resources :attachments

  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'


end
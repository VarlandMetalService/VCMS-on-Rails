Rails.application.routes.draw do

  resources :opto_messages
  root                        'vcms#home'
  get     'login'         =>  'sessions#new'
  post    'login'         =>  'sessions#create'
  delete  'logout'        =>  'sessions#destroy'

  resources :employee_notes
  resources :shift_notes
  resources :users
  resources :permissions
  resources :attachments
  resources :documents do
    collection do
      get :get_google_meta
    end
  end
  resources :categories

  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'


end
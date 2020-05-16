Rails.application.routes.draw do
  get 'invalid_contacts/index'
  root 'contacts#index'
  devise_for :users
  resources :contacts
  resources :invalid_contacts, only: [:index]
  resources :import_files do 
    collection { post :import }
  end
end

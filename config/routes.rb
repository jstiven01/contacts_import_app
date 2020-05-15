Rails.application.routes.draw do
  root 'contacts#index'
  devise_for :users
  resources :contacts
  resources :import_files do 
    collection { post :import }
  end
end

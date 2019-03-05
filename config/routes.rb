Rails.application.routes.draw do

  root "fees#index"

  get 'uploads', :to => 'uploads#uploads', as: 'uploads'
  post 'uploads/master_import_2016'
  post 'uploads/master_import_2019'
  devise_for :users
  
  resources :fees
  resources :fee_details

  resources :receipts

  get 'generate_receipt/:fee_id', :to => 'receipts#generate_receipt', as: 'generate_receipt'

end

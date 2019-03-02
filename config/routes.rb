Rails.application.routes.draw do

  root "fees#index"

  get 'uploads', :to => 'uploads#uploads', as: 'uploads'
  post 'uploads/detail_import_csv'
  post 'uploads/master_import_csv'
  devise_for :users
  
  resources :fees
  resources :fee_details

  resources :receipts

  get 'generate_receipt/:fee_id', :to => 'receipts#generate_receipt', as: 'generate_receipt'

end

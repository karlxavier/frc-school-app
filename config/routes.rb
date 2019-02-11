Rails.application.routes.draw do

  root "fees#index"

  devise_for :users
  
  resources :fees
  resources :fee_details

  resources :receipts

  get 'generate_receipt/:fee_id', :to => 'receipts#generate_receipt', as: 'generate_receipt'

end

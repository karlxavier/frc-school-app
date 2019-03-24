Rails.application.routes.draw do

  root "fees#index"

  get 'uploads', :to => 'uploads#uploads', as: 'uploads'
  post 'uploads/master_import_2016'
  post 'uploads/master_import_2019'
  post 'uploads/master_import_feb'
  post 'uploads/opbal_2016'
  post 'uploads/import_mar_revenue2019'
  devise_for :users
  
  resources :fees
  resources :fee_details
  resources :students

  resources :receipts
  get 'reports_collections', to: 'reports#reports_collections', as: 'reports_collections'

  get 'generate_receipt/:fee_id', :to => 'receipts#generate_receipt', as: 'generate_receipt'
  get 'generate_fees/:student_id', :to => 'receipts#generate_fees', as: 'generate_fees'

end

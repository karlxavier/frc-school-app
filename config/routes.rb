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
  resources :revenues

  resources :receipts
  get 'reports_collections', to: 'reports#reports_collections', as: 'reports_collections'
  get 'reports_revenues', to: 'reports#reports_revenues', as: 'reports_revenues'

  # get 'generate_all_revenue', :to => 'fee_details#generate_all_revenue', as: 'generate_all_revenue'
  get 'generate_revenue/:fee_id', :to => 'fee_details#generate_revenue', as: 'generate_revenue'
  get 'generate_all_revenue', :to => 'fee_details#generate_all_revenue', as: 'generate_all_revenue'
  post 'create_all_revenue', :to => 'fee_details#create_all_revenue', as: 'create_all_revenue'
  get 'generate_receipt/:fee_id', :to => 'receipts#generate_receipt', as: 'generate_receipt'
  get 'generate_fees/:student_id', :to => 'receipts#generate_fees', as: 'generate_fees'

  get 'reminders', :to => 'fees#reminders', as: 'reminders'
  get 'send_reminders', :to => 'fees#send_reminders', as: 'send_reminders'

end

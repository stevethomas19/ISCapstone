Rails.application.routes.draw do
  devise_for :admins
  root 'dashboards#index'

  namespace :admin do
    resources :pcc_infos do
      collection { post :import_file }
    end
    # post '/import_file', to: "pcc_infos#import_file", as: :import_file
  end
end

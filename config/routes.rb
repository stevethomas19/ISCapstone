Rails.application.routes.draw do
  devise_for :admins
  root 'dashboards#index'

  namespace :admin do
    resources :pcc_infos do
      member do
        post :import_file
      end
    end
  end
end

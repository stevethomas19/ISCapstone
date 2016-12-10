Rails.application.routes.draw do
  devise_for :admins
  root 'dashboards#index'
  get '/dashboard', to: 'dashboards#tableau'
  get '/predict', to: 'dashboards#predict'

  namespace :admin do
    resources :pcc_infos do
      collection { post :import_file }
    end
  end
end

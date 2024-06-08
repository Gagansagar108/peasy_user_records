Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  scope '/peasy' do
    resources :users, only: [:index, :show, :update, :destroy]
    root to: 'users#index'
  end

  post '/peasy/users/delete', to: 'users#destroy'
  get '/peasy/list_users', to: 'users#list_user_records'
  post '/peasy/fetch_new_records', to: 'users#fetch_new_records'
  get 'peasy/users_count', to : 'users#users_count'

  require 'sidekiq/web'
  require 'sidekiq/cron/web'

    # mount Sidekiq::Web in your Rails app
  mount Sidekiq::Web => "peasy/sidekiq"
end

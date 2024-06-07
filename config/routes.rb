Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  scope '/peasy' do
    resources :users, only: [:index, :show, :update, :destroy]
    root to: 'users#index'
  end
  
  post '/peasy/users', to: 'users#index'

  require 'sidekiq/web'
  require 'sidekiq/cron/web'

    # mount Sidekiq::Web in your Rails app
  mount Sidekiq::Web => "peasy/sidekiq"
end

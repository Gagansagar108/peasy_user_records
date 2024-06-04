Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  scope '/peasy' do
    resources :users
    resources :user_records
    root to: 'home#index'
  end

  require 'sidekiq/web'
  require 'sidekiq/cron/web'

    # mount Sidekiq::Web in your Rails app
  mount Sidekiq::Web => "peasy/sidekiq"
end

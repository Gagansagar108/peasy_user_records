class CreateUserRecords
    include Sidekiq::Worker
    sidekiq_options queue: :default
  
    def perform(args = {})
      # Your background job logic goes here
      https://randomuser.me/api/?results=20
  
    end
end 
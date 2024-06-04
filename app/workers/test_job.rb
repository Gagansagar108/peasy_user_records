class TestJob
    include Sidekiq::Worker
    sidekiq_options queue: :default
  
    def perform(args = {})
      # Your background job logic goes here
      User.create!(uuid: Random.hex, name: {name: "#{Random.alphanumeric}gagan"} )
  
    
    end
  end

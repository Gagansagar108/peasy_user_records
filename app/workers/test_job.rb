class TestJob
    include Sidekiq::Worker
    sidekiq_options queue: :default
  
    def perform(args = {})
      # Your background job logic goes here
      User.create!(uuid: Randon.hex, name: {name: "#{Random.alphanumeric}gagan"} )
  
      # Example: Send an email notification
      # UserMailer.with(user: User.find(args[:user_id])).welcome_email.deliver_now
    end
  end

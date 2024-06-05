class UpdateDailyUserRecordsStatsJob
    include Sidekiq::Worker
    sidekiq_options queue: :default
  
    def perform(args = {})
        date = Time.zone.now.to_date
        daily_users = User.where("users.created_at   Wed, 05 Jun 2024")
      end 
    end
end 
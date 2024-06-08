class UpdateDailyUserRecordsStatsJob
    include Sidekiq::Worker
    sidekiq_options queue: :default
  
    def perform(args = {})
        UserRecordsHelper.create_gender_wise_users_count()
    end
end 
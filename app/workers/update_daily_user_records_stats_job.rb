class UpdateDailyUserRecordsStatsJob
    include Sidekiq::Worker
    sidekiq_options queue: :default
  
    def perform(args = {})
        UserRecordsHelper::get_gender_wise_users_count()
    end
end 
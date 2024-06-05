class UpdateDailyUserRecordsStatsJob
    include Sidekiq::Worker
    sidekiq_options queue: :default
  
    def perform(args = {})
        
      end 
    end
end 
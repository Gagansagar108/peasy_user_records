class UpdateDailyUserRecordsStatsJob
    include Sidekiq::Worker
    sidekiq_options queue: :default
  
    def perform(args = {})
        date_of_entry = Time.zone.now.to_date
        daily_users = User.where(date_of_entry: date_of_entry)
        genders_count = daily_users.group(:gender).count
        params = {date_of_entry: date_of_entry}
        params.merge!(genders_count)

        create_daily_records(params)
    end

    def create_daily_records(params)
       user_record = UserRecords.new(params)
       user_record.save!
    end 
end 
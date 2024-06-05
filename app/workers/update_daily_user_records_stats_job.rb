class UpdateDailyUserRecordsStatsJob
    include Sidekiq::Worker
    sidekiq_options queue: :default
  
    def perform(args = {})
        date_of_entry = Time.zone.now.to_date
        daily_users = User.where(date_of_entry: date_of_entry)
        genders_count = daily_users.group(:gender).count
        params = {date_of_entry: date_of_entry}
        params.merge!({female_count: genders_count['female'], male_count: genders_count['male']})

        create_daily_records(params)
    end

    def create_daily_records(params)
       user_record = UserRecord.find_or_initialize_by(date_of_entry: params[:date_of_entry])
       user_record.assign_attributes(params)
       user_record.save!
    end 
end 
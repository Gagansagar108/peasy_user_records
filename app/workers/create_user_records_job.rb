class CreateUserRecordsJob
    include Sidekiq::Worker
    sidekiq_options queue: :default
  
    def perform(args = {})
      Rails.cache.write('user_job_last_exectuted_at', Time.zone.now.time, expires_in: 1.minutes)
      response = UserClient.get('https://randomuser.me/api', {"results": 20})
      records = response.deep_symbolize_keys[:results]
      
      new_user_counter = {} 
      
      records.each do |record|
        user_uuid = record[:login].to_h[:uuid]
        
        age = record[:dob].to_h[:age]
        
        attributes = %i[gender name location age]
        
        params = record.slice(*attributes)
        
        params[:age] = age
        params[:date_of_entry] = Time.zone.now.to_date

        user = User.find_or_initialize_by(uuid: user_uuid)

        if user.new_record?
          new_user_counter["#{params[:gender]}"] += 1
        end 

        user.assign_attributes(params)
        
        user.save
      end 
      
      update_redis_data(new_user_counter)
    end

    def update_redis_data
      redis_data = UsersHelper.get_users_count_redis_data
     
      unless redis_data
        users = UsersHelper.get_gender_wise_user_counts      
        redis_data = UsersHelper.set_users_count_redis_data(users)
      end 

      Rails.cache.delete('user_job_last_exectuted_at')
      
    end 
end  
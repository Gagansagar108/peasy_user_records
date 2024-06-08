class CreateUserRecordsJob
    include Sidekiq::Worker
    sidekiq_options queue: :default
  
    def perform(args = {})
      key = 'last_exectuted_at' 

      Rails.cache.write(key, Time.zone.now.time, expires_in: 1.minutes)

      response = UserClient.get('https://randomuser.me/api', {"results": 20})
      records = response.deep_symbolize_keys[:results]
      records.each do |record|
        user_uuid = record[:login].to_h[:uuid]
        
        age = record[:dob].to_h[:age]
        
        attributes = %i[gender name location age]
        
        params = record.slice(*attributes)
        
        params[:age] = age
        params[:date_of_entry] = Time.zone.now.to_date

        user = User.find_or_initialize_by(uuid: user_uuid)
        
        user.assign_attributes(params)
        
        user.save
      end 

      update_redis_data
      
    end

    def update_redis_data
      users = User.group(:gender).count
      
      redis_keys = {}
      
      keys = %w[male female].each{ |gender| redis_keys["#{gender}_users_count"] = users[gender] }
      
      Rails.cache.write_multi(redis_keys)
      Rails.cache.delete(key)
    end 
end  
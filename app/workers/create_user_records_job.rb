class CreateUserRecordsJob
    include Sidekiq::Worker
    sidekiq_options queue: :default
  
    def perform(args = {})
      response = UserClient.get('https://randomuser.me/api', {"results": 20})
      records = response.deep_symbolize_keys[:results]
      records.each do |record|
        user_uuid = record[:login].to_h[:uuid]
        
        age = record[:dob].to_h[:age]
        
        attributes = %i[gender name location age]
        
        params = record.slice(*attributes)
        
        params[:age] = age
       
        user = User.find_or_initialize_by(uuid: user_uuid)
        
        user.assign_attributes(params)
        
        user.save
      end 

       
    end

    def update_redis_data()
      users_count = User.select(:id).count
    end 
end  
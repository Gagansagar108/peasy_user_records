class CreateUserRecordsJob
    include Sidekiq::Worker
    sidekiq_options queue: :default, :retry => 0
  
    def perform(args = {})
      Rails.cache.write('user_job_last_exectuted_at', Time.zone.now.time, expires_in: 1.minutes)
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
    end
end  
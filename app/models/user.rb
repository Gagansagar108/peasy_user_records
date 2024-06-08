class User < ApplicationRecord
    has_one :record, class_name: :UserRecord, primary_key: :date_of_entry, foreign_key: :date_of_entry
     
    before_validation :set_query_name

    include ActiveModel::Dirty
    define_attribute_methods 

    after_destroy :sync_daily_records_stats
    
    after_create :update_redis_count

    def set_query_name
        name = self.name.to_h
        location = self.location.to_h
        self.query_data = "#{name['title']} #{name['first']} #{name['last']} #{location['city']}".downcase
        
    end 

    def sync_daily_records_stats
        UserRecordsHelper.create_gender_wise_users_count({date_of_entry: self.date_of_entry}) if self.record
        update_redis_count(-1)
    end 
    
    def update_redis_count(amount = 1)
        key = "#{self.gender}"
        redis = Redis.new
        redis.incrby('total_users_count', amount)
        redis.incrby('key', amount)
    end 

end
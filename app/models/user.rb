class User < ApplicationRecord
    has_one :record, class_name: :UserRecord, primary_key: :date_of_entry, foreign_key: :date_of_entry
     
    before_validation :set_query_name

    include ActiveModel::Dirty
    define_attribute_methods 

    after_destroy :sync_daily_records_stats

    def set_query_name
        name = self.name.to_h
        location = self.location.to_h
        self.query_data = "#{name['title']} #{name['first']} #{name['last']} #{location['city']}".downcase
        
    end 

    def sync_daily_records_stats
        UserRecordsHelper.create_gender_wise_users_count({date_of_entry: self.date_of_entry}) if self.record
        
        key = "#{self.gender}_users_count"
        
        count = Rails.cache.fetch(key)
        Rails.cache.write( key, count -1)
    end 
end
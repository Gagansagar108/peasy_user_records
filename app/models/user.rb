class User < ApplicationRecord
    has_one :record, class_name: :UserRecord, primary_key: :date_of_entry, foreign_key: :date_of_entry
     
    before_validation :set_query_name

    include ActiveModel::Dirty
    define_attribute_methods 

    after_destroy :update_daily_records_stats

    def set_query_name
        name = self.name.to_h
        location = self.location.to_h
        self.query_data = "#{name['title']} #{name['first']} #{name['last']} #{location['city']}".downcase
    end 

    def update_daily_records_stats
        record = self.record
        UserRecordsHelper.create_gender_wise_users_count({date_of_entry: self.date_of_entry}) if record
    end 
end
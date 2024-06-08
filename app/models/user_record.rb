class UserRecord < ApplicationRecord
    has_many :users, class_name: :User, primary_key: :date_of_entry, foreign_key: :date_of_entry

    include ActiveModel::Dirty
    define_attribute_methods 

    before_save :do_changes

    def do_changes
        binding.pry
        return if (changes.keys & ['male_count', 'female_count']).blank?
        update_daily_records_stats
    end 


    def update_daily_records_stats
       
        query = "SELECT gender, AVG(age) from users where age is not null and date_of_entry = '#{self.date_of_entry}' GROUP by gender"
      
        data = ActiveRecord::Base.connection.execute(query).as_json.map(&:deep_symbolize_keys)
      
        params = data.inject({}){|params,y| params.merge!("#{y[:gender]}_avg_age": y[:avg])}
      
        self.update!(params)
    end
end 
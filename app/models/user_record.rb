class UserRecord < ApplicationRecord
    has_many :users, class_name: :User, primary_key: :date_of_entry, foreign_key: :date_of_entry

    include ActiveModel::Dirty
    define_attribute_methods 
    #after_save :do_changes

    def do_changes
        return unless changed?
        query = "SELECT gender, AVG(age) from users where age is not null GROUP by gender"
        data = ActiveRecord::Base.connection.execute(query).as_json.map(&:deep_symbolize_keys)
        params = data.inject({}){|params,y| params.merge!("#{y[:gender]}_avg_age": y[:avg])}
        self.update!(params)
    end 
end 
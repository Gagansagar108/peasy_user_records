class User < ApplicationRecord
    has_one :record, class_name: :UserRecord, primary_key: :date_of_entry, foreign_key: :date_of_entry
     
    before_validation :set_query_name

    def set_query_name
        binding.pry
        name = self.name
        location = self.location
        self.query_data = "#{name[:title]} #{name[:first]} #{name[:last]} #{location[:city]}".downcase
    end 
end
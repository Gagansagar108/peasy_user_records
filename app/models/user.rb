class User < ApplicationRecord
    has_one :record, class_name: :UserRecord, primary_key: :date_of_entry, foreign_key: :date_of_entry
     
    before_validation :set_query_name

    include ActiveModel::Dirty
    define_attribute_methods 

    def set_query_name
        name = self.name.to_h
        location = self.location.to_h
        self.query_data = "#{name['title']} #{name['first']} #{name['last']} #{location['city']}".downcase
    end 



    #after_save :do_changes

    def do_changes
        binding.pry
        return unless changed?
    
    end 

end
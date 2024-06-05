class UserRecord < ApplicationRecord
    
    has_many :users, class_name: :User, primary_key: :date_of_entry, foreign_key: :date_of_entry

    include ActiveModel::Dirty
    
    after_save :do_changes


    def do_changes
        binding.pry
        return unless changed?
        
    end 

end 
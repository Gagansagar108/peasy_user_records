class UserRecord < ApplicationRecord
    include ActiveModel::Dirty
    define_attribute_methods :male_count, :femmale_count

    after_save :update_changes

    private
  
    def update_changes
      return unless changed?
      binding.pry
      changes.each do |attribute, (old_value, new_value)|
        
      end
    end
end 
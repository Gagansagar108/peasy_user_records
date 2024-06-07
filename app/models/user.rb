class User < ApplicationRecord
    has_one :record, class_name: :UserRecord, primary_key: :date_of_entry, foreign_key: :date_of_entry

    before_validation do
        name = self.name
        location = self.location
        self.query_data = "#{name[:title]} #{name[:first]} #{name[:last]} #{location[:city]}".downcase
      end
end
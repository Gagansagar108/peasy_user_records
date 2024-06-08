module UsersHelper

    def self.get_gender_wise_user_counts
        users = User.group(:gender).count
        return users
    end 
end 
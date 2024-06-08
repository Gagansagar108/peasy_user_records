module UsersHelper

    def self.get_gender_wise_user_counts
        users = User.group(:gender).count
        return users.merge!('total__users_count' => users.values.sum)
    end 

    def get_users_count_redis_data(count)
        keys = %w[male female total]
        return  Rails.cache.fetch_multi(keys)
    end 

    def set_users_count_redis_data(users_count_data)
        redis_keys = {}
        keys = %w[male female total].each{ |gender| redis_keys["#{gender}_users_count"] = users[gender] }
        return Rails.cache.write_multi(redis_keys)
    end
end 
class UsersHelper
    def initialize(users_count_data = None)
        @users_count_data = users_count_data
    end

    def set_users_count_data
        return if @users_count_data
        users = User.group(:gender).count
        @users_count_data = users.merge!('total__users_count' => users.values.sum)
    end 
    
    def get_users_count_data
        set_users_count_data
        @users_count_data 
    end 

    def get_users_count_redis_data(count)
        keys = UserConstants::REDIS_COUNT_KEYS 
        return Rails.cache.fetch_multi(keys){|key| key}
    end 

    def set_users_count_redis_data(users_count_data)
        redis_keys = {}
        keys = UserConstants::REDIS_COUNT_KEYS.each{ |gender| redis_keys["#{gender}_users_count"] = users_count_data[gender] }
        return Rails.cache.write_multi(redis_keys)
    end
end 
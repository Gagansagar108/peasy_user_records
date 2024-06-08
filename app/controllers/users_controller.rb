class UsersController < ApplicationController

    def index
        data = list_user
        render_user_list(data)
    end
   
    def destroy
        id = params[:user_id]

        user = User.where(params[:id]).take
        
        if user.blank?
            render json: { errors: 'user does not exists' },
            status: :unprocessable_entity
            return
        end
        
        ActiveRecord::Base.transaction do
            user.destroy
        end 

        index
    end 

    def list_user
        page = params[:page] || 1
        query = User.page(page).per(10)

        query = apply_query_filters(query) if params[:user_search_query]

        return {users: query, total_page: query.total_pages, total_count: query.total_count, current_page: page}
    end 

    def apply_query_filters(query)
        query_name = params[:user_search_query]
        query = query.where("query_data ilike '%#{query_name}%'")
        return query
    end 

    def render_user_list(user)
        binding.pry
        @template = Liquid::Template.parse(File.read(Rails.root.join("app", "views","users", "dashboard.liquid.erb"))).render({'data' => user.as_json })
        render inline:  @template
    end

    def fetch_new_records
        key = 'user_job_last_exectuted_at'

        if Rails.cache.fetch(key)
            render json: {"message": "pleae wait, still in queue"}
            return 
        end 

        CreateUserRecordsJob.perform_async()
        index
    end 

    def users_count
        user_counter_data = UsersCountDataHelper.new
        keys = UserConstants::REDIS_COUNT_KEYS.map{ |gender| "#{gender}_users_count"}
        
        data = Rails.cache.fetch_multi(*keys){|key| user_counter_data.get_users_count_data[key.split('_').first]}
      
        render json: data 
    end 
end 
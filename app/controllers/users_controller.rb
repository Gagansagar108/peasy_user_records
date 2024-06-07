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

        user.delete
        index
    end 

    def list_user
        page = params[:page] || 1
        query = User.page(page).per(10)
        binding.pry
        apply_query_filters(query) if params[:query]

        return {users: query, total_page: query.total_pages, total_count: query.total_count, current_page: page}
    end 

    def apply_query_filters(query)
        query_name = params[:query]
        query = query.where("query_data ilike %#{query_name}%")
        return query
    end 

    def render_user_list(user)
        @template = Liquid::Template.parse(File.read(Rails.root.join("app", "views","users", "dashboard.liquid.erb"))).render({'data' => user.as_json })
        render inline:  @template
    end


end 
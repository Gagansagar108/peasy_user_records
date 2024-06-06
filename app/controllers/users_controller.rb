class UsersController < ApplicationController

    def index
        @user = list_user[:query]
        @template = Liquid::Template.parse(File.read(Rails.root.join("app", "views","users", "dashboard.liquid"))).render({'users' => @user.as_json })

        render inline:  @template
    end


    def list_user
        page = params[:page] || 10
        query = User.page(page).per(10)
    
        apply_query_filters(query)
        return {query: query, total_page: query.total_pages, total_count: query.total_count, current_page: page}
    end 

    def apply_query_filters(query)
        query
    end 

end 
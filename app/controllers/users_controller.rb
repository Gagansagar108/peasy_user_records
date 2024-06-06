class UsersController < ApplicationController

    def index
        @user = User.all
        binding.pry
        @template = Liquid::Template.parse(File.read(Rails.root.join("app", "views","users", "dashboard.liquid"))).render({'users' => @user.as_json })

        render inline:  @template

    end


    def list_user(params)
        page = params[:page]
        query = User.page(page).per(10)
    
        apply_query_filters(query)
    end 

    def apply_query_filters(query)
        query
    end 

end 
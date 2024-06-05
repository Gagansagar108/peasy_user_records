class UsersController < ApplicationController

    def index
        @user = User.all
        render json: {"e": 3344}
        render :inline => Liquid::Template.parse(File.read(Rails.root.join("app", "views","users", "dashboard.liquid"))).render({'products' => @user})
    end

end 
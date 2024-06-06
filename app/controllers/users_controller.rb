class UsersController < ApplicationController

    def index
        @user = User.all
        template = Liquid::Template.parse(File.read(Rails.root.join("app", "views","users", "dashboard.liquid.erb")))

        render locals: { user: @user }

    end

end 
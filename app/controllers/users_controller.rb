class UsersController < ApplicationController

    def index
        @user = User.all
        binding.pry
        @template = Liquid::Template.parse(File.read(Rails.root.join("app", "views","users", "dashboard.liquid"))).render({'users' => @user })

        render inline:  @template

    end

end 
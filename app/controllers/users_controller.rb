class UsersController < ApplicationController

    def index
        @user = User.all

        @template = Liquid::Template.parse("hi {{name}}").render('user' => @user)


        render inline:  @template

    end

end 
class UsersController < ApplicationController

    def index
        @user = User.all

        @template = Liquid::Template.parse("hi {{name}}") 
        @template.render('name' => 'tobi')

        render inline:  @template

    end

end 
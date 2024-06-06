class UsersController < ApplicationController

    def index
        @user = User.all

        @template = Liquid::Template.parse("hi {{name}}") # Parses and compiles the template
        @template.render('name' => 'tobi')

    end

end 
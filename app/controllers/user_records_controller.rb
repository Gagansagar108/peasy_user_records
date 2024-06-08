class UsersController < ApplicationController
    def index
        data = list_user_records
        render_user_record_list(data)
    end
   
    def list_user_records
        page = params[:page] || 1
        query = UserRecord.page(page).per(10)
        return {user_records: query, total_page: query.total_pages, total_count: query.total_count, current_page: page}
    end 


    def render_user_record_list(data)
        @template = Liquid::Template.parse(File.read(Rails.root.join("app", "views","user_records", "dashboard.liquid.erb"))).render({'data' => data.as_json })
        render inline:  @template
    end
end 
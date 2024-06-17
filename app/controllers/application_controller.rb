class ApplicationController < ActionController::Base
    config.web_console.whiny_requests = false
    protect_from_forgery with: :null_session
end

class ApplicationController < ActionController::Base
    def cur_user
        User.find(session[:cur_uid]) if session[:cur_uid]
    end
    def require_login
        if !cur_user
            flash[:alert] = "Login to perform operations !!!"
            redirect_to root_path
        end
    end
end

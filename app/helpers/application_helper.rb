module ApplicationHelper
    def cur_user
        User.find(session[:cur_uid]) if session[:cur_uid]
    end
end

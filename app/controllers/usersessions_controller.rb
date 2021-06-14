class UsersessionsController < ApplicationController
    def new

    end
    def create 
        cur_user = User.find_by(email: params[:usersessions][:email])
        if cur_user && cur_user.authenticate(params[:usersessions][:password])
            session[:cur_uid] = cur_user.id
            flash[:notice] = "Successfully , Logged In !"
            redirect_to cur_user
        else
            flash.now[:alert] = "Invlaid credentials! retry"
            render 'new'
        end
    end
    def destroy
        session[:cur_uid] = nil
        flash[:notice] = "Successfully , Logged Out!"
        redirect_to root_path
    end
end
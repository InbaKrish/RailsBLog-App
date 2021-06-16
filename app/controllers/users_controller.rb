class UsersController < ApplicationController
    before_action :set_user, only: [:edit, :update, :show, :destroy]
    before_action :require_login, only: [:edit, :update ]
    before_action :check_cur_user, only: [:edit, :update, :destroy ]

    def new
        @user = User.new
    end

    def show
        @articles = @user.articles
    end

    def index
        @users = User.all
    end

    def edit
    end

    def update
        if @user.update(user_params)
            flash[:notice] = "#{@user.user_name} details updated successfully..."
            redirect_to articles_path
        else
            render 'edit'
        end
    end

    def create
        @user = User.new(user_params)
        if @user.save
            session[:cur_uid] = @user.id
            flash[:notice] = "#{@user.user_name} Signed Up Successfully..."
            redirect_to articles_path
        else
            render 'new'
        end
    end
    def destroy
        @user.destroy
        session[:cur_uid] = nil
        flash[:alert] = "Your profile and Your Articles DESTROYED , Successfully !!!"
        redirect_to root_path
    end


    private
    def set_user
        @user = User.find(params[:id])
    end
    def user_params
        params.require(:user).permit(:user_name,:email,:password)
    end
    def check_cur_user
        if cur_user != @user
            flash[:alert] = "You are not the owner of this Profile !!!"
            redirect_to user_path(@user)
        end
    end
end
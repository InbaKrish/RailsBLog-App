class UsersController < ApplicationController
    before_action :set_user, only: [:edit, :update, :show]

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
            session[:user_id] = @user.id
            flash[:notice] = "#{@user.user_name} Signed Up Successfully..."
            redirect_to articles_path
        else
            render 'new'
        end
    end

    private
    def set_user
        @user = User.find(params[:id])
    end
    def user_params
        params.require(:user).permit(:user_name,:email,:password)
    end
end
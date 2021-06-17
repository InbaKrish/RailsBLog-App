class UsersController < ApplicationController
    before_action :set_user, only: [:edit, :update, :show, :destroy]
    before_action :author_signed_in?  , only: [:edit, :update ]
    before_action :authenticate_author!, only: [:edit, :update, :destroy ]

    def show
        @articles = @user.articles
    end

    def index
        @users = Author.all
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

    def destroy
        @user.destroy
        flash[:alert] = "Your profile and Your Articles DESTROYED , Successfully !!!"
        redirect_to root_path
    end


    private
    def set_user
        @user = Author.find(params[:id])
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
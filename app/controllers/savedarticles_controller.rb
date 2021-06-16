class SavedarticlesController < ApplicationController
    before_action :require_login 

    def create
        @user = cur_user
        @save_article = @user.savedarticles.new
        @save_article.article_id = params[:article_id]
        @save_article.save
        flash[:notice] = "Article added to Saved_Articles !!!"
        redirect_to article_path(params[:article_id])
    end
    def index 
        @user = cur_user
        @articles = @user.savedarticles
        @articles = @articles.map{ |sa| Article.find(sa.article_id) }
    end
    def destroy
        @s_article = Savedarticle.find_by(article_id:params[:article_id])
        if @s_article
            @s_article.destroy()
            flash.now[:notice] = "Removed article !!"
            render :index
        else
            flash[:notice] = "Article not found or saved !!"
            redirect_to article_path(params[:article_id])
        end
    end
end

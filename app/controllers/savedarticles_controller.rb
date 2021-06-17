class SavedarticlesController < ApplicationController
    before_action :author_signed_in?

    def create
        @user = current_author
        @save_article = @user.savedarticles.new
        @save_article.article_id = params[:article_id]
        @save_article.save
        flash[:notice] = "Article added to Saved_Articles !!!"
        redirect_to article_path(params[:article_id])
    end
    def index 
        @user = current_author
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

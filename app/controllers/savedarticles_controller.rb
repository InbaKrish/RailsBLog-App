class SavedarticlesController < ApplicationController
    before_action :author_signed_in?
    before_action :authenticate_author!

    def create
        user = current_author
        save_article = user.savedarticles.new
        save_article.article_id = params[:article_id]
        save_article.save
        flash[:notice] = "Article added to Saved_Articles !!!"
        redirect_to articles_path()
    end
    def index 
        user = current_author
        @articles = user.savedarticles
        @articles = @articles.map{ |sa| Article.find(sa.article_id) }
    end
    def destroy
        saved_article = Savedarticle.find_by(article_id:params[:article_id])
        if saved_article
            saved_article.destroy()
            flash[:notice] = "Removed article from Saved_Articles !!"
            redirect_to articles_path()
        else
            flash[:notice] = "Article not found or saved !!"
            redirect_to articles_path()
        end
    end
end

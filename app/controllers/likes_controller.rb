class LikesController < ApplicationController
    before_action :set_article
    before_action :author_signed_in?

    def new
    end
    def create 
        if already_liked?
            @liked.destroy()
        else
            @article.likes.create(author_id: current_author.id)
        end
        redirect_to articles_path()
    end

    private
    def set_article
        @article = Article.find(params[:article_id])
    end
    def already_liked?
        @liked = Like.find_by(author_id: current_author.id, article_id: params[:article_id])
    end
end

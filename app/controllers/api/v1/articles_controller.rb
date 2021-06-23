class Api::V1::ArticlesController < ApplicationController
    before_action :set_article, only: [ :show]
    protect_from_forgery with: :null_session

    #all users json
    def all_articles
        @articles = Article.all
        render json: @articles
    end
    #user's articles
    def index
        @author = Author.find(params[:id])
        @articles = @author.articles
        render json: @articles
    end
    #user json
    def show
        render json: @article
    end
    #create
    def create
        @article = Article.new(article_params)
        @article.author_id = current_author.id
        if @article.save
            render json: @article
        else
            render json: @article.errors
        end
    end

    private

    def article_params
        params.permit(:title,:description,:content)
    end

    def set_article
        @article = Article.find(params[:id])
    end
end

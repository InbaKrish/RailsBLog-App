class Api::V1::ArticlesController < ApplicationController
    before_action :set_article, only: [ :show]
    protect_from_forgery with: :null_session
    before_action :doorkeeper_authorize!
    before_action :current_author, only: [:create]

    def all_articles
        @articles = Article.all
        render json: @articles ,except: [:created_at,:updated_at]
    end
    #user's articles
    def index
        @author = Author.find(params[:id])
        @articles = @author.articles
        render json: @articles, except: [:created_at,:updated_at]
    end

    def show
        body = @article.body.body.to_plain_text
        render :json => @article.as_json(except: [:created_at,:updated_at]).merge(:body => body)
    end
    #create
    def create
        @article = Article.new(article_params)
        @article.author_id = current_author.id
        if @article.save
            render json: @article,except: [:created_at,:updated_at]
        else
            render json: @article.errors
        end
    end
    
    private
    def current_author
        Author.find(doorkeeper_token.resource_owner_id)
    end

    def article_params
        params.permit(:title,:description,:body)
    end

    def set_article
        @article = Article.find(params[:id])
    end
end

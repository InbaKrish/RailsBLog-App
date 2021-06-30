class ArticlesController < ApplicationController

    before_action :set_article, only: [:show, :edit, :update, :destroy]
    before_action :authenticate_author! , except: [:show, :index]
    before_action :check_user , only: [:edit, :update, :destroy]

    def show
    end
    def index
        @articles = Article.all.order(updated_at: :desc).includes(:author)
    end
    def search
        if params[:search].blank? 
            redirect_to articles_path
        else
            @key = params[:search][0].downcase
            @articles = Article.all.where("lower(title) LIKE :search", search: "%#{@key}%").includes(:author)
        end
    end
    def new
        @article = Article.new
    end

    def edit
    end

    def create
        @article = Article.new(article_params)
        @article.author_id = current_author.id
        if @article.save
            flash[:notice] = "Article created successfully"
            redirect_to @article
        else
            render :new
        end
    end

    def update
        if @article.update(article_params)
            flash[:notice] = "Article updated successfully"
            redirect_to @article
        else
            render :edit
        end

    end

    def destroy
        @article.destroy()
        redirect_to articles_path
    end

    private

    def article_params
        params.require(:article).permit(:title,:description,:content)
    end

    def set_article
        @article = Article.find(params[:id])
    end

    def check_user
        if current_author != @article.author
            flash[:alert] = "You are not the owner of this Article !!!"
            redirect_to articles_path
        end
        return true
    end
end
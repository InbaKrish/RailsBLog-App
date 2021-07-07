class ArticlesController < ApplicationController

    before_action :set_article, only: [:show, :edit, :update, :destroy]
    before_action :authenticate_author! , except: [:show, :index]
    before_action :check_user , only: [:edit, :update, :destroy]

    def show
        if current_author
           if not @article.already_viewed(current_author)
            @view = @article.views.new(author_id:current_author.id)
            @view.save
           end
        end

        respond_to do |format|
            format.html
            format.pdf do
              render pdf: "#{@article.title}-by #{@article.author.username}-PDF", template: "articles/articlepdf.html.erb",
                 layout: 'pdf.html'
            end
        end
    end
    def index
        @articles = Article.all.order(updated_at: :desc).includes(:author,:categories)
        @articles = @articles.filter_by_title(params[:search]) if params[:search].present?
        @articles = @articles.filter_by_category(params[:category][:name]) if params[:category].present? and params[:category][:name].present?
        #@all_articles = Article.all
        respond_to do |format|
            format.html
            format.csv { send_data Services::Conversion.new.to_csv, filename: "articles-#{Date.today}.csv" }
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
        if Content::CheckContent.new.is_abusive(@article.body)
            current_author.lock_access!
            flash[:notice] = "Your article contains abusive content , Your account is banned !!!"
            redirect_to new_author_session_path
        else
            if @article.save
                flash[:notice] = "Article created successfully"
                redirect_to @article
            else
                render :new
            end
        end
    end

    def update
        if Content::CheckContent.new.is_abusive(@article.body)
            current_author.lock_access!
            flash[:notice] = "Your article contains abusive content , Your account is banned !!!"
            redirect_to new_author_session_path
        end
        if @article.update(article_params)
            flash[:notice] = "Article updated successfully"
            redirect_to @article
        else
            render :edit
        end

    end

    def destroy
        @saved_articles = Savedarticle.where("article_id = ?",@article.id)
        @saved_articles.delete_all()
        @article.destroy()
        redirect_to articles_path
    end

    private

    def article_params
        params.require(:article).permit(:title,:description,:body,category_ids: [] )
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
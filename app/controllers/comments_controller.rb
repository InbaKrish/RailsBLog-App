class CommentsController < ApplicationController
    before_action :set_article
    before_action :author_signed_in?
    before_action :authenticate_author!, only: [:create, :destroy]

    def new
    end
    def create
        @comment = @article.comments.create(params.require(:comment).permit(:content))
        @comment.user_id = current_author.id
        if @comment.save
            flash[:notice] = "Comment Posted successfully !!!"
            redirect_to article_path(@article)
        else
            flash[:notice] = "Error posting comment, retry !!!"
            redirect_to article_path(@article)
        end
    end
    def destroy 
        @comment = Comment.find_by(user_id:current_author.id,article_id:params[:article_id])
        if @comment
            @comment.destroy
            flash[:notice] = "Comment deleted , Successfully !"
            redirect_to article_path(@article)
        else
            flash[:notice] = "Comment not available"
            redirect_to article_path(@article)
        end
    end

    private
    def set_article
        @article = Article.find(params[:article_id])
    end
end
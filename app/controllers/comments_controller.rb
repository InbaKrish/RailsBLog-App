class CommentsController < ApplicationController
    before_action :author_signed_in?

    def new
    end
    def create
        @article = Article.find(params[:article_id])
        @comment = @article.comments.create(params.require(:comment).permit(:content))
        @comment.user_id = current_author.id
        @comment.save
        flash[:notice] = "Comment Posted successfully !!!"
        redirect_to article_path(@article)
    end
end
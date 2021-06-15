class CommentsController < ApplicationController
    def new
    end
    def create
        @article = Article.find(params[:article_id])
        @comment = @article.comments.create(params.require(:comment).permit(:content))
        @comment.user_id = cur_user.id
        @comment.save
        flash[:notice] = "Comment Posted successfully !!!"
        redirect_to article_path(@article)
    end
end
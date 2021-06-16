module ApplicationHelper
    def cur_user
        User.find(session[:cur_uid]) if session[:cur_uid]
    end
    def already_saved(article)
        articles = cur_user.savedarticles
        articles = articles.map{ |obj| obj.article_id }
        return articles.include?(article)
    end
end

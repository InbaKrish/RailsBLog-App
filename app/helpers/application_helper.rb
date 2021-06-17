module ApplicationHelper
    def already_saved(article)
        articles = current_author.savedarticles
        articles = articles.map{ |obj| obj.article_id }
        return articles.include?(article)
    end
end

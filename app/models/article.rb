class Article < ApplicationRecord
    belongs_to :author
    has_many :comments, dependent: :delete_all
    has_many :likes, dependent: :delete_all
    has_many :views, dependent: :delete_all

    has_rich_text :body
    validates :body , presence: true, length: {minimum: 400}

    has_many :article_categories,dependent: :delete_all
    has_many :categories, through: :article_categories

    validates :title , presence: true,uniqueness: true, length: {minimum: 6, maximum: 80}
    validates :description, presence: true, length: {minimum: 15, maximum: 600}

    scope :filter_by_title, -> (title) {where("lower(title) LIKE :search", search: "%#{title.downcase}%")}

    def self.filter_by_category(category)
        cg = Category.where(name: category)
        articles = cg.map{ |cat| cat.articles}
        articles = articles.flatten
        return articles
    end

    def already_saved(current_author)
        articles = current_author.savedarticles
        #articles = articles.map{ |obj| obj.article_id }
        articles = articles.pluck(:article_id)
        return articles.include?(self.id)
    end

    def already_viewed(current_author)
        views = self.views
        views = views.pluck(:author_id)
        return views.include?(current_author.id)
    end
end

require 'uri'
require 'net/http'
require "net/https"
require 'openssl'
require "json"
module Content
    class CheckContent
        def initialize
            @content = ""
        end
        def is_abusive(content)
            @content = content.to_plain_text.to_s
            @content = @content.gsub(/[[:^ascii:]]/, "")
            api = "https://neutrinoapi.net/bad-word-filter?user-id=InbaKrish&api-key=JWwEyBi3ht8YGNDM6HMDvV06BEvEcsZlkQKBwyswN6k3rK6S&content="+@content
            url = URI(api)

            http = Net::HTTP.new(url.host, url.port)
            http.use_ssl = true
            http.verify_mode = OpenSSL::SSL::VERIFY_NONE
            request = Net::HTTP::Post.new(url)
            response = http.request(request)
            if response.kind_of? Net::HTTPSuccess
                response = JSON.parse response.body
                puts response
                return response["bad-words-list"].join(',')
            end
            return false
        end
    end
end
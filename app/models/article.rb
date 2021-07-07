class Article < ApplicationRecord
    belongs_to :author
    has_many :comments, dependent: :delete_all
    has_many :likes, dependent: :delete_all
    has_many :views, dependent: :delete_all

    has_many :article_categories
    has_many :categories, through: :article_categories

    validates :title , presence: true,uniqueness: true, length: {minimum: 6, maximum: 80}
    validates :description, presence: true, length: {minimum: 15, maximum: 600}
    validates :content, presence: true, length: {minimum: 400}

    scope :filter_by_title, -> (title) {where("lower(title) LIKE :search", search: "%#{title.downcase}%")}

    def self.filter_by_category(category)
        cg = Category.where(name: category)
        articles = cg.map{ |cat| cat.articles}
        articles = articles.flatten
        return articles
    end

    def self.to_csv
        attributes = %w{id title description}

        CSV.generate(headers: true) do |csv|
            csv << attributes
            all.each do |article|
                csv << article.attributes.values_at(*attributes)
            end
        end
    end

    def already_saved(current_author)
        articles = current_author.savedarticles
        #articles = articles.map{ |obj| obj.article_id }
        articles = articles.pluck(:article_id)
        return articles.include?(self)
    end
end
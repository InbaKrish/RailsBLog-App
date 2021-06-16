class Article < ApplicationRecord

    belongs_to :user
    has_many :comments, dependent: :delete_all
    validates :title , presence: true, length: {minimum: 6, maximum: 80}
    validates :description, presence: true, length: {minimum: 15, maximum: 600}
end
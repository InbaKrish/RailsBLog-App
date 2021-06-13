class Article < ApplicationRecord

    belongs_to :user

    validates :title , presence: true, length: {minimum: 6, maximum: 80}
    validates :description, presence: true, length: {minimum: 15, maximum: 600}
end
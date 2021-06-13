class User < ApplicationRecord

    has_many :articles

    validates :user_name, presence: true, uniqueness: { case_sensitive: false },  length: {minimum: 3, maximum: 80}

    EMAIL_VALID_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :email, presence: true, uniqueness: { case_sensitive: false },  length: {minimum: 3, maximum: 80},
                format: {with: EMAIL_VALID_REGEX}

    has_secure_password
end
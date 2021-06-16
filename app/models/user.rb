class User < ApplicationRecord
    before_save { self.email = email.downcase }
    has_many :articles, dependent: :destroy
    has_many :savedarticles, dependent: :delete_all
    validates :user_name, presence: true, uniqueness: { case_sensitive: false },  length: {minimum: 3, maximum: 80}

    EMAIL_VALID_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :email, presence: true, uniqueness: { case_sensitive: false },  length: {minimum: 3, maximum: 80},
                format: {with: EMAIL_VALID_REGEX, message: "Provied Valid email address"}

    has_secure_password
end
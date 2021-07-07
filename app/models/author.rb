class Author < ApplicationRecord
  has_many :articles, dependent: :destroy
  has_many :savedarticles, dependent: :delete_all
  has_many :likes, dependent: :delete_all
  has_many :views, dependent: :delete_all

  before_save { self.email = email.downcase }
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,:lockable

  validates :email, format: URI::MailTo::EMAIL_REGEXP

  # the authenticate method from devise documentation
  def self.authenticate(email, password)
    author = Author.find_for_authentication(email: email)
    author&.valid_password?(password) ? author : nil
  end
  def unlock_author
    self.locked_at = nil
    self.failed_attempts = 0 if respond_to?(:failed_attempts=)
    self.unlock_token = nil  if respond_to?(:unlock_token=)
    save(:validate => false)
  end
  def username
    email.split('@')[0].capitalize
  end
end

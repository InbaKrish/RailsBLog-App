class Author < ApplicationRecord
  has_many :articles, dependent: :destroy
  has_many :savedarticles, dependent: :delete_all
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def username
    email.split('@')[0].capitalize
  end
end

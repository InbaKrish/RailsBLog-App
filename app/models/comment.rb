class Comment < ApplicationRecord
  belongs_to :article

  validates :content, presence: true, length: {minimum: 6, maximum: 300}
  validates :user_id, presence: true
end

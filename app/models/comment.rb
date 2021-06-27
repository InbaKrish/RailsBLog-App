class Comment < ApplicationRecord
  belongs_to :article

  validates :content, presence: true, length: {minimum: 6, maximum: 80}
end

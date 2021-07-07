class View < ApplicationRecord
  belongs_to :author
  belongs_to :article

  validates :author_id , presence: true
  validates :article_id , presence: true
end

class Savedarticle < ApplicationRecord
  belongs_to :author

  validates :author_id, presence: true
end

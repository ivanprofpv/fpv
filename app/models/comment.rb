class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :drone

  acts_as_votable

  validates :body, presence: true
end

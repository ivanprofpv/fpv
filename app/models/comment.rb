class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :drone

  validates :body, presence: true
end

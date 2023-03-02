class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :drone

  acts_as_votable cacheable_strategy: :update_columns

  validates :body, presence: true
end

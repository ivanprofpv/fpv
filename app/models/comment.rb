include ActionView::RecordIdentifier

class Comment < ApplicationRecord
  
  belongs_to :user
  belongs_to :drone

  acts_as_votable cacheable_strategy: :update_columns

  validates :body, presence: true
  after_create_commit { broadcast_prepend_to [drone, :comments], target: "#{dom_id(drone)}_comments" }
end

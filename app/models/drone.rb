class Drone < ApplicationRecord
  belongs_to :user

  has_one_attached :foto
  has_rich_text :content
  
  validates :title, :body, presence: true
end

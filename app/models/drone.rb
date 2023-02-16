class Drone < ApplicationRecord
  belongs_to :user
  belongs_to :category

  has_one_attached :foto
  has_many_attached :gallerys
  has_rich_text :content

  validates :title, :body, presence: true
end

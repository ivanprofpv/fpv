class Drone < ApplicationRecord
  belongs_to :user

  has_many_attached :fotos
  has_rich_text :content
  
  validates :title, :body, presence: true
end

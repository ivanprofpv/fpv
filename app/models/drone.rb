class Drone < ApplicationRecord
  belongs_to :user

  has_many_attached :fotos
  
  validates :title, :body, presence: true
end

class Drone < ApplicationRecord
  validates :title, :body, presence: true
end

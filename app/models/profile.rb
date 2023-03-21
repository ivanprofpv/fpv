class Profile < ApplicationRecord
  belongs_to :user

  has_one_attached :avatar, dependent: :destroy

  validates_length_of :name, maximum: 50, message: 'Shorten the name to 50 characters',
                             allow_blank: true
  validates_length_of :about, maximum: 300, message: 'Shorten the about to 300 characters',
                              allow_blank: true
  validates_length_of :city, maximum: 50, message: 'Shorten the city to 50 characters',
                             allow_blank: true

  validates :avatar, content_type: { in: ['image/png', 'image/jpeg', 'image/jpg', 'image/webp'], message: 'must be a JPEG, PNG or JPG' },
                     size: { less_than: 3.megabytes, message: 'image is too large, max size 1 image - 3MB' }
end

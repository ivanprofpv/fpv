class Gallery < ApplicationRecord
  belongs_to :drone

  has_one_attached :gallery_foto, dependent: :destroy

  validates :gallery_foto, content_type: { in: ['image/png', 'image/jpeg', 'image/jpg'], message: 'must be a JPEG, PNG or JPG' },
                              size: { less_than: 5.megabytes, message: 'image is too large, max size 1 image - 5MB' }
end

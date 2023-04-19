class Drone < ApplicationRecord
  belongs_to :user
  belongs_to :category

  has_one_attached :foto, dependent: :destroy
  has_many_attached :gallerys, dependent: :destroy

  has_many :comments, dependent: :destroy
  has_many :components, dependent: :destroy

  has_rich_text :content

  paginates_per 12

  acts_as_votable cacheable_strategy: :update_columns

  accepts_nested_attributes_for :components, reject_if: :all_blank, allow_destroy: true

  validates :title, presence: true
  validates_length_of :title, maximum: 50, message: 'Shorten the title to 50 characters'

  validates :foto, :gallerys, content_type: { in: ['image/png', 'image/jpeg', 'image/jpg'], message: 'must be a JPEG, PNG or JPG' },
                              size: { less_than: 5.megabytes, message: 'image is too large, max size 1 image - 5MB' }
end

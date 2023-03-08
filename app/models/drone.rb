class Drone < ApplicationRecord

  belongs_to :user
  belongs_to :category

  has_one_attached :foto, dependent: :destroy
  has_many_attached :gallerys, dependent: :destroy

  has_many :comments, dependent: :destroy
  has_many :components, dependent: :destroy

  has_rich_text :content

  acts_as_votable cacheable_strategy: :update_columns

  accepts_nested_attributes_for :components, reject_if: :all_blank, allow_destroy: true

  validates :title, :body, presence: true
  validates :foto, :gallerys, content_type: { in: ['image/png', 'image/jpeg', 'image/jpg'], message: 'must be a JPEG, PNG or JPG' },
                              size: { less_than: 5.megabytes , message: 'image is too large, max size 1 image - 5MB' }

end

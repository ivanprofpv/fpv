class Drone < ApplicationRecord
  belongs_to :user
  belongs_to :category

  has_one_attached :foto, dependent: :destroy
  has_many_attached :gallerys, dependent: :destroy
  has_rich_text :content

  validates :title, :body, presence: true
  validate :validate_gallery_filetypes

  private

  def validate_gallery_filetypes
    return unless gallerys.attached?

    gallerys.each do |attachment| 
      unless attachment.content_type.in?(%w[image/jpeg image/png image/jpg])
        errors.add(:gallerys, 'Must be a JPEG, PNG or JPG')
      end
    end
  end
end

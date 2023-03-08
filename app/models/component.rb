class Component < ApplicationRecord

  belongs_to :drone
  belongs_to :component_category

  accepts_nested_attributes_for :component_category, reject_if: :all_blank, allow_destroy: true

  validates :title, presence: true
  validates_format_of :url, allow_blank: true, :with => /\A(https?:\/\/)?([\da-z\.-]+)\.([a-z\.]{2,6})([\/\w\.-]*)*\/?\Z/i
  # validates :price, numericality: { only_integer: true }
end

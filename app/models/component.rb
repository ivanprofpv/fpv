class Component < ApplicationRecord
  belongs_to :drone
  belongs_to :component_category

  accepts_nested_attributes_for :component_category, reject_if: :all_blank, allow_destroy: true

  validates :title, presence: true
  validates :component_category_id, presence: true
  validates_length_of :title, maximum: 30, message: 'Shorten the title to 30 characters'
  validates_length_of :price, maximum: 5, message: 'Shorten the price to 5 characters',
                              allow_blank: true
  validates_format_of :url, allow_blank: true,
                            with: %r{\A(https?://)?([\w-]{1,32}\.[\w-]{1,32})[^\s@]}i
  validates :price, numericality: { only_integer: true }, allow_blank: true
end

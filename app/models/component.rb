class Component < ApplicationRecord

  belongs_to :drone

  validates :title, presence: true
  # validates_format_of :url, :with => /\A(https?:\/\/)?([\da-z\.-]+)\.([a-z\.]{2,6})([\/\w\.-]*)*\/?\Z/i

end

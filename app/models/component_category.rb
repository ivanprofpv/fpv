class ComponentCategory < ApplicationRecord
  has_many :components
  
  validates :title, presence: true
end

class Profile < ApplicationRecord
  belongs_to :user

  validates_length_of :name, maximum: 50, message: 'Shorten the name to 50 characters',
                             allow_blank: true
  validates_length_of :about, maximum: 300, message: 'Shorten the about to 300 characters',
                              allow_blank: true
  validates_length_of :city, maximum: 50, message: 'Shorten the city to 50 characters',
                             allow_blank: true
end

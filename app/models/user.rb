class User < ApplicationRecord
  has_many :drones, dependent: :destroy
  has_many :comments, dependent: :destroy

  has_one :profile, dependent: :destroy
  accepts_nested_attributes_for :profile

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :trackable, :confirmable

  acts_as_voter

  def author?(subject)
    self.id == subject.user_id
  end
end

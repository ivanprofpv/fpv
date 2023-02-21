class User < ApplicationRecord
  has_many :drones, dependent: :destroy
  has_many :likes

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, 
         :trackable, :confirmable

  def author?(subject)
    self.id == subject.user_id
  end
end

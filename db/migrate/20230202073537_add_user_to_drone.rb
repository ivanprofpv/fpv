class AddUserToDrone < ActiveRecord::Migration[6.1]
  def change
    add_belongs_to :drones, :user, index: true, foreign_key: true
  end
end

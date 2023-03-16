class RemoveColumnBodyToDrones < ActiveRecord::Migration[6.1]
  def change
    remove_column :drones, :body
  end
end

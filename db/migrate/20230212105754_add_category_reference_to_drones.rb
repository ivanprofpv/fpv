class AddCategoryReferenceToDrones < ActiveRecord::Migration[6.1]
  def change
    add_reference :drones, :categories, foreign_key: true
  end
end

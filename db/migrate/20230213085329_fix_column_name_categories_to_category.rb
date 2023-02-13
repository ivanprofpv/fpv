class FixColumnNameCategoriesToCategory < ActiveRecord::Migration[6.1]
  def change
    rename_column :drones, :categories_id, :category_id
  end
end

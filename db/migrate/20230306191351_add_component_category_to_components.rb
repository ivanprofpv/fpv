class AddComponentCategoryToComponents < ActiveRecord::Migration[6.1]
  def change
    add_reference :components, :component_category, null: false, foreign_key: true
  end
end

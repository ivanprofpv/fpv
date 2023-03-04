class CreateComponents < ActiveRecord::Migration[6.1]
  def change
    create_table :components do |t|
      t.string :title, null: false
      t.string :url
      t.integer :price

      t.references :drone, null: false, foreign_key: true

      t.timestamps
    end
  end
end

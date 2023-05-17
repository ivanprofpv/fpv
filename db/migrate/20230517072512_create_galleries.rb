class CreateGalleries < ActiveRecord::Migration[6.1]
  def change
    create_table :galleries do |t|
      t.references :drone, null: false, foreign_key: true

      t.timestamps
    end
  end
end

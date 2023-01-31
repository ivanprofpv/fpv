class CreateDrones < ActiveRecord::Migration[6.1]
  def change
    create_table :drones do |t|
      t.string :title, null: false
      t.string :body, null: false

      t.timestamps
    end
  end
end

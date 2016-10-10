class CreateGoals < ActiveRecord::Migration
  def change
    create_table :goals do |t|
      t.integer :user_id, null: false
      t.string :title, null: false
      t.text :description
      t.boolean :private, default: false, null: false
      t.boolean :completed, default: false, null: false

      t.timestamps null: false
    end
    add_index :goals, :user_id
  end
end

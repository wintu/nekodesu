class CreateData < ActiveRecord::Migration[5.2]
  def change
    create_table :data do |t|
      t.integer :data_set_id, null: false
      t.integer :display_type, null: false, default: 0
      t.string :target_label
      t.text :body, null: false

      t.timestamps
    end
    add_index :data, :data_set_id
  end
end

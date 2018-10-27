class CreateData < ActiveRecord::Migration[5.2]
  def change
    create_table :data do |t|
      t.integer :user_id, null: false
      t.integer :data_set_id
      t.text :body, null: false

      t.timestamps
    end
    add_index :data, :user_id
    add_index :data, :data_set_id
  end
end

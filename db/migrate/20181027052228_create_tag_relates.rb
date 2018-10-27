class CreateTagRelates < ActiveRecord::Migration[5.2]
  def change
    create_table :tag_relates do |t|
      t.integer :data_set_id, null: false
      t.integer :tag_id, null: false

      t.timestamps
    end
    add_index :tag_relates, :data_set_id
    add_index :tag_relates, :tag_id
  end
end

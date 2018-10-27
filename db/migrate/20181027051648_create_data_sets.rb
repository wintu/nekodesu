class CreateDataSets < ActiveRecord::Migration[5.2]
  def change
    create_table :data_sets do |t|
      t.string :title, null: false
      t.integer :user_id, null: false
      t.integer :category_id
      t.text :description
      t.string :link

      t.timestamps
    end
  end
end

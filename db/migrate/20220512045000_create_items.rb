class CreateItems < ActiveRecord::Migration[7.0]
  def change
    create_table :items do |t|
      t.string :name
      t.decimal :price
      t.text :description
      t.string :sku
      t.integer :count
      t.string :deletedComment

      t.timestamps
    end
    add_index :items, :sku, unique: true
  end
end

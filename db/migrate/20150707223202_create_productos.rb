class CreateProductos < ActiveRecord::Migration
  def change
    create_table :productos do |t|
      t.string :name
      t.integer :price

      t.timestamps null: false
    end
  end
end

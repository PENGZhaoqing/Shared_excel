class CreateStockDbs < ActiveRecord::Migration
  def change
    create_table :stock_dbs do |t|
      t.string :complete_time
      t.string :client_name
      t.string :product_code
      t.string :product_name
      t.string :standard
      t.string :kind
      t.string :supplier
      t.integer :export_num
      t.string :project_code
      t.timestamps null: false
    end
  end
end

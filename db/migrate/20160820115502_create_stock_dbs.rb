class CreateStockDbs < ActiveRecord::Migration
  def change
    create_table :stock_dbs do |t|
      t.string :product
      t.string :import_company
      t.string :import_num
      t.string :export_company
      t.string :export_num

      t.timestamps null: false
    end
  end
end

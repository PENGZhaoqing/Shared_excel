class CreateSupplierDbs < ActiveRecord::Migration
  def change
    create_table :supplier_dbs do |t|
      t.string :product
      t.string :supplier
      t.timestamps null: false
    end
  end
end

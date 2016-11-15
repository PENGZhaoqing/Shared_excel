class CreateSupplierExcels < ActiveRecord::Migration
  def change
    create_table :supplier_excels do |t|
      t.attachment :file
      t.timestamps null: false
    end
  end
end

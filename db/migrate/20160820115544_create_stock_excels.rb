class CreateStockExcels < ActiveRecord::Migration
  def change
    create_table :stock_excels do |t|
      t.attachment :file
      t.timestamps null: false
    end
  end
end

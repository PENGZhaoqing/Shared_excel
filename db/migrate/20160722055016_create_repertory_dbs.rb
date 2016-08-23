class CreateRepertoryDbs < ActiveRecord::Migration
  def change
    create_table :repertory_dbs do |t|
      t.string :name
      t.string :standard
      t.integer :num
      t.string :supplier
      t.string :product_code
      t.string :product_kind

      t.timestamps null: false
    end
  end
end

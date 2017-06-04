class CreateWarningDbs < ActiveRecord::Migration
  def change
    create_table :warning_dbs do |t|
      t.string :supplier
      t.string :product_code
      t.integer :safe_num
      t.integer :common_num
      t.boolean :match, default: false
      t.timestamps null: false
    end
  end
end

class CreateRepertoryDbs < ActiveRecord::Migration
  def change
    create_table :repertory_dbs do |t|
      t.string :name
      t.string :standard
      t.string :kind
      t.integer :num
      t.string :supplier
      t.timestamps null: false
    end
  end
end

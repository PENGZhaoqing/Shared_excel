class CreateMappingDbs < ActiveRecord::Migration
  def change
    create_table :mapping_dbs do |t|
      t.string :supplier1
      t.string :supplier2
      t.string :auth_token
      t.timestamps null: false
    end
  end
end

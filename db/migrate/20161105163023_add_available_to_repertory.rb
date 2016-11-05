class AddAvailableToRepertory < ActiveRecord::Migration
  def change
    add_column :repertory_dbs, :available, :integer
    add_column :repertory_dbs, :unit, :string
    add_column :stock_dbs, :bill_name, :string
  end
end

class AddAvailableToRepertory < ActiveRecord::Migration
  def change
    add_column :repertory_dbs, :available, :integer
    add_column :repertory_dbs, :unit, :string
    add_column :repertory_dbs, :model, :string
    add_column :stock_dbs, :project_name, :string
  end
end

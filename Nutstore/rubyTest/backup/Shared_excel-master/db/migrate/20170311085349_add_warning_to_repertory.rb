class AddWarningToRepertory < ActiveRecord::Migration
  def change
    add_column :repertory_dbs, :warning, :integer
  end
end

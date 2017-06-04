class ModifyWarningInRepertory < ActiveRecord::Migration
  def change
    remove_column :repertory_dbs, :warning, :integer
    add_column :repertory_dbs, :safe_num, :integer
    add_column :repertory_dbs, :common_num, :integer
    add_column :repertory_dbs, :need_num, :integer
  end
end

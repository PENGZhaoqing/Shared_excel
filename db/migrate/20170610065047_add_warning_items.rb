class AddWarningItems < ActiveRecord::Migration
  def change
    add_column :warning_dbs, :product_name, :string
    add_column :warning_dbs, :standard, :string
  end
end

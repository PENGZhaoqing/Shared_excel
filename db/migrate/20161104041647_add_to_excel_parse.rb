class AddToExcelParse < ActiveRecord::Migration
  def change
    add_column :supplier_excels, :parse, :boolean, default: false
    add_column :repertory_excels, :parse, :boolean, default: false
    add_column :project_excels, :parse, :boolean, default: false
    add_column :stock_excels, :parse, :boolean, default: false
    add_column :mapping_excels, :parse, :boolean, default: false

  end
end

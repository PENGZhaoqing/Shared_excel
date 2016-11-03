class CreateMappingExcels < ActiveRecord::Migration
  def change
    create_table :mapping_excels do |t|
      t.attachment :file
      t.boolean :parse, default: false
      t.timestamps null: false
    end
  end
end

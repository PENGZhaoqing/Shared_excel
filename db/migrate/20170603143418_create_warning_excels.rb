class CreateWarningExcels < ActiveRecord::Migration
  def change
    create_table :warning_excels do |t|
      t.attachment :file
      t.boolean :parse
      t.timestamps null: false
    end
  end
end

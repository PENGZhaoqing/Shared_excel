class CreateProjectExcels < ActiveRecord::Migration
  def change
    create_table :project_excels do |t|
      t.attachment :file
      t.boolean :parse, default: false
      t.timestamps null: false
    end
  end
end

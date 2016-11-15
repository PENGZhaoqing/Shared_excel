class CreateProjectExcels < ActiveRecord::Migration
  def change
    create_table :project_excels do |t|
      t.attachment :file
      t.timestamps null: false
    end
  end
end

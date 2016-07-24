class CreateProjectDbs < ActiveRecord::Migration
  def change
    create_table :project_dbs do |t|
      t.string :company
      t.string :build_way
      t.string :project_name
      t.string :code
      t.string :approve_time
      t.string :begin_at
      t.string :end_at

      t.timestamps null: false
    end
  end
end

class CreateRepertoryExcels < ActiveRecord::Migration
  def change
    create_table :repertory_excels do |t|
      t.attachment :file
      t.timestamps null: false
    end
  end
end

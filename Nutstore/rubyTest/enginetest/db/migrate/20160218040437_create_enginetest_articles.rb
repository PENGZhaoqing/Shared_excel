class CreateEnginetestArticles < ActiveRecord::Migration
  def change
    create_table :enginetest_articles do |t|
      t.string :title
      t.text :text

      t.timestamps null: false
    end
  end
end

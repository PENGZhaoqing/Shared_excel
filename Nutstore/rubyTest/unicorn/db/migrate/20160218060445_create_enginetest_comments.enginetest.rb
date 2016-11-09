# This migration comes from enginetest (originally 20160218041047)
class CreateEnginetestComments < ActiveRecord::Migration
  def change
    create_table :enginetest_comments do |t|
      t.integer :article_id
      t.text :text

      t.timestamps null: false
    end
  end
end

# This migration comes from enginetest (originally 20160218061855)
class AddAuthorIdToEnginetestArticles < ActiveRecord::Migration
  def change
    add_column :enginetest_articles, :author_id, :integer
  end
end

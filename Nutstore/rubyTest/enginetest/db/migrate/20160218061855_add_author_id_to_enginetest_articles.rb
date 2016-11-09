class AddAuthorIdToEnginetestArticles < ActiveRecord::Migration
  def change
    add_column :enginetest_articles, :author_id, :integer
  end
end

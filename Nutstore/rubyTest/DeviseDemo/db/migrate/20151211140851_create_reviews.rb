class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.integer :potatoes
      t.text    :comments
      t.references :moviegoer
      t.references :movie
      t.timestamps null: false
    end
  end
end

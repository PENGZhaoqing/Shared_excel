class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :title
      t.text :description
      t.datetime :start_time
      t.string :url
      t.datetime :created_at
      t.datetime :updated_at
      t.integer :venue_id
      t.integer :duplicated_of_id
      t.datetime :end_time
      t.string :rrlue
      t.text :venue_details
      t.boolean  :locked,          default: false
    end

    # change_table :events do |t|
    #   t.remove :duplicated_of_id
    # end
  end
end

class CreateVenues < ActiveRecord::Migration
  def change
    create_table :venues do |t|
      t.string   :title
      t.text     :description
      t.string   :address
      t.string   :url
      t.datetime :created_at
      t.datetime :updated_at
      t.string   :street_address
      t.string   :locality
      t.string   :region
      t.string   :postal_code
      t.string   :country
      t.decimal  :latitude,       precision: 7, scale: 4
      t.decimal  :longitude,       precision: 7, scale: 4
      t.string   :email
      t.string   :telephone
      t.integer  :source_id
      t.integer  :duplicate_of_id
      t.boolean  :closed,                             default: false
      t.boolean  :wifi,                               default: false
      t.text     :access_notes
      t.integer  :events_count
    end
  end
end

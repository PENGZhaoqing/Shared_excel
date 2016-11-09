class RemoveDuplicateOfIdFromEvents < ActiveRecord::Migration
  change_table :events do |t|
    t.rename :duplicated_of_id, :duplicate_of_id
  end
end

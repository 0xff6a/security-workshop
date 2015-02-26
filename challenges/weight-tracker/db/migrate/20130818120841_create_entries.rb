class CreateEntries < ActiveRecord::Migration
  def change
    create_table :entries do |t|
      t.integer  :user_id
      t.integer  :weight
      t.datetime :weighed_at
      t.timestamps
    end
  end
end

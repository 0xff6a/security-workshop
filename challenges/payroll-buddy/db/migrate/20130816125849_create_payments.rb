class CreatePayments < ActiveRecord::Migration
  def change  
    create_table :payments do |t|
      t.integer :user_id
      t.integer :amount
      t.datetime :transacted_at
      t.timestamps
    end
  end
end

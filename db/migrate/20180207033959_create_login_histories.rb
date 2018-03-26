class CreateLoginHistories < ActiveRecord::Migration
  def change
    create_table :login_histories do |t|
      t.integer :member_id
      t.string :user_agent
      t.string :browser_info
      t.timestamp :login_time
      t.string :location
      t.string :ip_address

      t.timestamps null: false
    end
  end
end

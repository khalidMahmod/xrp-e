class AddDisableTimeToMember < ActiveRecord::Migration
  def change
    add_column :members, :disable_time, :timestamp
  end
end

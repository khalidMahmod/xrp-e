class AddIsDisabledToMember < ActiveRecord::Migration
  def change
    add_column :members, :is_disabled, :integer, default: 0
  end
end

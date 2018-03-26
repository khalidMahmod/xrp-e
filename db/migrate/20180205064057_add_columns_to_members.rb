class AddColumnsToMembers < ActiveRecord::Migration
  def change
    add_column :members, :salt, :string
    add_column :members, :google_secret, :string
    add_column :members, :fa_enable, :boolean , :default => false
  end
end

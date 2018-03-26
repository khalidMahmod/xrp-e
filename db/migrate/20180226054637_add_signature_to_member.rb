class AddSignatureToMember < ActiveRecord::Migration
  def change
    add_column :members, :signature, :string, :limit => 100
  end
end

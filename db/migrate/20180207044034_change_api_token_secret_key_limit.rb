class ChangeAPITokenSecretKeyLimit < ActiveRecord::Migration
  def change
    change_column :api_tokens, :access_key, :string, :limit => 100
    change_column :api_tokens, :secret_key, :string, :limit => 100
  end
end

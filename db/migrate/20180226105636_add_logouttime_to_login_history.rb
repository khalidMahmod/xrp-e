class AddLogouttimeToLoginHistory < ActiveRecord::Migration
  def change
    add_column :login_histories, :logouttime, :timestamp
  end
end

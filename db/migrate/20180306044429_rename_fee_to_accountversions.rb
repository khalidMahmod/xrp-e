class RenameFeeToAccountversions < ActiveRecord::Migration
  def change
    rename_column :account_versions, :fee, :fees
  end
end

class AddColumnsToCurrencyAmounts < ActiveRecord::Migration
  def change
    add_column :currency_amounts, :deposit_fee, :decimal, precision: 32, scale: 16
    add_column :currency_amounts, :withdraw_fee, :decimal, precision: 32, scale: 16
  end
end

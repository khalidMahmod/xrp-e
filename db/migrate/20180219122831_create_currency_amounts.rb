class CreateCurrencyAmounts < ActiveRecord::Migration
  def change
    create_table :currency_amounts do |t|
      t.string :name
      t.string :code
      t.decimal :max_deposit,   precision: 32, scale: 16
      t.decimal :min_deposit,   precision: 32, scale: 16
      t.decimal :max_withdraw,  precision: 32, scale: 16
      t.decimal :min_withdraw,  precision: 32, scale: 16
      t.timestamps null: false
    end
  end
end

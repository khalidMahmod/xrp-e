class CurrencyAmount < ActiveRecord::Base
  validates :deposit_fee, format: { with: /\A\d+(?:\.\d{0,16})?\z/ }, numericality: { less_than: 10000000 }
  validates :withdraw_fee, format: { with: /\A\d+(?:\.\d{0,16})?\z/ }, numericality: { less_than: 10000000 }
  validates :max_deposit, format: { with: /\A\d+(?:\.\d{0,16})?\z/ }, numericality: {  less_than: 10000000 }
  validates :min_deposit, format: { with: /\A\d+(?:\.\d{0,16})?\z/ }, numericality: {  less_than: 10000000 }
  validates :max_withdraw, format: { with: /\A\d+(?:\.\d{0,16})?\z/ }, numericality: {  less_than: 10000000 }
  validates :min_withdraw, format: { with: /\A\d+(?:\.\d{0,16})?\z/ }, numericality: {  less_than: 10000000 }
end

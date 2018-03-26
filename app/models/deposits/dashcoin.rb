module Deposits
  class Dashcoin < ::Deposit
    include ::AasmAbsolutely
    include ::Deposits::Coinable
  end
end
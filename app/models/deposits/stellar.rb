module Deposits
  class Stellar < ::Deposit
    include ::AasmAbsolutely
    include ::Deposits::Coinable
  end
end
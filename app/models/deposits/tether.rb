module Deposits
  class Tether < ::Deposit
    include ::AasmAbsolutely
    include ::Deposits::Coinable
  end
end
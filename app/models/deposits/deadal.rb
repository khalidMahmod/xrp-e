module Deposits
  class Deadal < ::Deposit
    include ::AasmAbsolutely
    include ::Deposits::Coinable
  end
end
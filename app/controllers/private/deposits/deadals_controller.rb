module Private
  module Deposits
    class DeadalsController < BaseController
      include ::Deposits::CtrlCoinable
    end
  end
end
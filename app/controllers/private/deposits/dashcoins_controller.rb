module Private
  module Deposits
    class DashcoinsController < BaseController
      include ::Deposits::CtrlCoinable
    end
  end
end
module Private
  module Deposits
    class TethersController < BaseController
      include ::Deposits::CtrlCoinable
    end
  end
end
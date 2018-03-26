module Private
  module Deposits
    class StellarsController < BaseController
      include ::Deposits::CtrlCoinable
    end
  end
end
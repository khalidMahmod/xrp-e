module Private::Withdraws
  class StellarsController < ::Private::Withdraws::BaseController
    include ::Withdraws::Withdrawable
  end
end
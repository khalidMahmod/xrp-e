module Private::Withdraws
  class DeadalsController < ::Private::Withdraws::BaseController
    include ::Withdraws::Withdrawable
  end
end
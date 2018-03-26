module Private
  class FeesController < BaseController
    layout 'funds'
    helper_method :tabs

    def index
      @currency_amounts = CurrencyAmount.all
    end
  end
end

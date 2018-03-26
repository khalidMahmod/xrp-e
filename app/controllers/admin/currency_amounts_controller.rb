module Admin
  class CurrencyAmountsController < BaseController
    respond_to :html, :json
    def index
      @currency_amounts = CurrencyAmount.all
    end
    def edit
      @currency_amount = CurrencyAmount.find(params[:id])
    end

    def update
      @currency_amount = CurrencyAmount.find(params[:id])
        @currency_amount.update(currency_params)
        respond_with_bip(@currency_amount)
    end

    private
    def currency_params
      params.require(:currency_amount).permit( :max_deposit,:min_deposit,:deposit_fee,:max_withdraw,:min_withdraw,:withdraw_fee,:name)
    end
  end
end

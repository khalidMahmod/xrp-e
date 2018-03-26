module Private::Withdraws
  class DollarsController< ::Private::Withdraws::BaseController
    include ::Withdraws::Withdrawable
    skip_before_action :fetch, only: :usd_withdraws

    def usd_withdraws
        @accounts = current_user.accounts
        @usd_balance = @accounts.find_by currency: 'usd'

        if @usd_balance.balance >= 10
            if params['fund_source'] == 'advcash'
                redirect_to 'https://advcash.com/en/solutions/developers/' and return
            elsif params['fund_source'] == 'epay'
                redirect_to 'http://www.epay.com' and return
            else
                redirect_to 'https://perfectmoney.is'
            end
        else
            redirect_to '/funds?#/withdraws/usd?error=true'
        end
    end

    def new

    end

    def create

    end
  end
end

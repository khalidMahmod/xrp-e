require "uri"
require "net/http"
module Private
  module Deposits
    class DollarsController < BaseController
      include ::Deposits::CtrlCoinable

      def usd_deposit
        if params['fund_source'] == 'advcash'
          redirect_to 'https://advcash.com/en/solutions/developers/' and return


=begin
          <form action="https://ssl.ditonlinebetalingssystem.dk/integration/ewindow/Default.aspx" method="post">
          <input name="merchantnumber" value="ENTER YOUR MERCHANT NUMBER HERE">
          <input name="amount" value="10495"> <input name="currency" value="DKK">
          <input name="windowstate" value="3"> <input type="submit" value=
              "Go to payment">
              </form>
=end


        elsif params['fund_source'] == 'epay'
          params = {'merchantnumber' => '123456789123',
                    'amount' => '200',
                    'currency' => value='DKK',
                    'windowstate' => '3',
                    'submit' => 'Submit'
          }
          redirect_to Net::HTTP.post_form(URI.parse('https://ssl.ditonlinebetalingssystem.dk/integration/ewindow/Default.aspx'), params)
          debugger
=begin
          puts x.body
          debugger
          puts "\n\n\n\n\n\n\n\n\n\n"
          puts x.header



            redirect_to 'http://www.epay.com' and return
=end

        else
            redirect_to 'https://perfectmoney.is' and return
        end
      end

      def new

      end

      def create

      end
    end
  end
end
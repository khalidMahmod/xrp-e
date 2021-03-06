module Private
  class AssetsController < BaseController
    skip_before_action :auth_member!, only: [:index]

    def index
      @usd_assets  = Currency.assets('usd')
      @btc_proof   = Proof.current :btc
      @usd_proof   = Proof.current :usd
      @ltc_proof   = Proof.current :ltc
      @xrp_proof   = Proof.current :xrp
      @bch_proof   = Proof.current :bch
      @dsh_proof   = Proof.current :dsh
      @xlm_proof   = Proof.current :xlm
      @usdt_proof   = Proof.current :usdt

      if current_user
        @btc_account = current_user.accounts.with_currency(:btc).first
        @usd_account = current_user.accounts.with_currency(:usd).first
        @xrp_account = current_user.accounts.with_currency(:xrp).first
        @ltc_account = current_user.accounts.with_currency(:ltc).first
        @bch_account = current_user.accounts.with_currency(:bch).first
        @dsh_account = current_user.accounts.with_currency(:dsh).first
        @xlm_account = current_user.accounts.with_currency(:xlm).first
        @usdt_account = current_user.accounts.with_currency(:usdt).first
      end
    end

    def partial_tree
      account    = current_user.accounts.with_currency(params[:id]).first
      @timestamp = Proof.with_currency(params[:id]).last.timestamp
      @json      = account.partial_tree.to_json.html_safe
      respond_to do |format|
        format.js
      end
    end

  end
end

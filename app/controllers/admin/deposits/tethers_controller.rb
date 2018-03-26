module Admin
  module Deposits
    class TethersController < ::Admin::Deposits::BaseController
      load_and_authorize_resource :class => '::Deposits::Satoshi'

      def index
        start_at = DateTime.now.ago(60 * 60 * 24 * 365)
        @tethers = @tethers.includes(:member).
          where('created_at > ?', start_at).
          order('id DESC').paginate(:page => params[:page], :per_page => 20)
      end

      def update
        @tether.accept! if @tether.may_accept?
        redirect_to :back, notice: t('.notice')
      end
    end
  end
end
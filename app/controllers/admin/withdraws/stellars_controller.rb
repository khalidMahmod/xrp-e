module Admin
  module Withdraws
    class StellarsController < ::Admin::Withdraws::BaseController
      load_and_authorize_resource :class => '::Withdraws::Satoshi'

      def index
        start_at = DateTime.now.ago(60 * 60 * 24)
        @one_stellars = @stellars.with_aasm_state(:accepted).order("id DESC")
        @all_stellars = @stellars.without_aasm_state(:accepted).where('created_at > ?', start_at).order("id DESC")
      end

      def show
      end

      def update
        @stellar.process!
        redirect_to :back, notice: t('.notice')
      end

      def destroy
        @stellar.reject!
        redirect_to :back, notice: t('.notice')
      end
    end
  end
end
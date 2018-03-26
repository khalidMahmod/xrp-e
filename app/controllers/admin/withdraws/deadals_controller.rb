module Admin
  module Withdraws
    class DeadalsController < ::Admin::Withdraws::BaseController
      load_and_authorize_resource :class => '::Withdraws::Satoshi'

      def index
        start_at = DateTime.now.ago(60 * 60 * 24)
        @one_deadals = @deadals.with_aasm_state(:accepted).order("id DESC")
        @all_deadals = @deadals.without_aasm_state(:accepted).where('created_at > ?', start_at).order("id DESC")
      end

      def show
      end

      def update
        @deadal.process!
        redirect_to :back, notice: t('.notice')
      end

      def destroy
        @deadal.reject!
        redirect_to :back, notice: t('.notice')
      end
    end
  end
end
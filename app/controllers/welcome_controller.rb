class WelcomeController < ApplicationController
  before_action :authentication_check
  layout 'landing'

  def index
  end
  private
  def authentication_check
    if current_user.present?
      if current_user.fa_enable && session[:check_varify_session] == "false"
        #render :partial => 'shared/check_verify'
        redirect_to member_mfa_session_check_verify_path
      end
    end
  end
end

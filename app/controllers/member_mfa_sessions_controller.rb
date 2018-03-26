class MemberMfaSessionsController < ApplicationController
  skip_before_action :check_mfa
  skip_before_action :two_factor_check, :only => [:check_varify, :verify]
  layout "landing"
  before_action :auth_verified!

  def new
    @user = current_user
  end

  def create
    @user = current_user
    if @user.google_authentic?(params[:auth][:mfa_code])
      if @user.fa_enable == false
        Member.update(@user.id, :fa_enable => true)
        session[:check_varify_session] = "true"
        flash[:notice]= "Two Factor Authenticator Successfully Enabled."
      else
        Member.update(@user.id, :fa_enable => false)
        flash[:notice]= "Two Factor Authenticator Successfully Disabled."
      end
      MemberMfaSession.create(@user)
        redirect_to root_path
    else
      flash[:error] = "Wrong code"
      render :new
    end
  end

  def check_varify
    @user = current_user
    if @user.fa_enable == false
      redirect_to root_path
    end
  end

  def verify
    @user = current_user
    if @user.google_authentic?(params[:auth][:mfa_code])
      session[:check_varify_session] = "true"
      redirect_to settings_path
    else
      flash[:error] = "Wrong code"
      render :check_varify
    end
  end

end


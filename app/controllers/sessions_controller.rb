class SessionsController < ApplicationController
  before_action :auth_member!, only: :destroy
  before_action :auth_anybody!, only: :failure
  skip_before_action :two_factor_check, :only => [:create, :destroy]
  def create
    @member = Member.from_auth(auth_hash)
    @logintime= LoginHistory.where(member_id: @member.id).last
    if @logintime.present?
      elapsed_time = (Time.now - @logintime.login_time).to_i.abs / 60
      if elapsed_time >= 60
        @logintime.update_attribute(:logouttime, @logintime.login_time + 1.hour)
      else
        return user_logged_in(@logintime) unless @logintime.logouttime.present?
      end
    end
    if @member.login_histories.count > 1
        @login_histories = @member.login_histories.last(2)
        if @login_histories[1].ip_address != @login_histories[0].ip_address
            return redirect_to(root_path, alert: "IP Address Does not Match! Please Check Your Email")
        end
    end
    return redirect_on_unsuccessful_sign_in unless @member
    return redirect_to(root_path, alert: t('.disabled')) if @member.disabled?
    reset_session rescue nil
    session[:member_id] = @member.id
    user_agent = UserAgent.parse(request.user_agent)
    user_ip = request.remote_ip
    url="http://ip-api.com/json/#{user_ip}"
    response = HTTParty.get(url)
    @location_info = response.parsed_response
    LoginHistory.insert(current_user,@location_info, user_agent )
    session[:signature] = LoginHistory.create_user_signature(current_user, @location_info, user_agent )
    session[:check_varify_session] = "false"
    save_session_key @member.id, cookies['_peatio_session']
    redirect_on_successful_sign_in
  end

  def failure
    redirect_to root_path, alert: t('.error')
  end
  def destroy
    @member= LoginHistory.where(member_id: current_user.id).last
    @member.update_attributes(:logouttime => DateTime.now )
    clear_all_sessions current_user.id
    reset_session
    redirect_to root_path
  end

private

  def auth_hash
    @auth_hash ||= request.env['omniauth.auth']
  end

  def redirect_on_successful_sign_in
    "#{params[:provider].to_s.upcase}_OAUTH2_REDIRECT_URL".tap do |key|
      if ENV[key]
        redirect_to ENV[key]
      else
        redirect_back_or_settings_page
      end
    end
  end

  def redirect_on_unsuccessful_sign_in
    redirect_to root_path, alert: t('.error')
  end
  def user_logged_in (logintime)
    redirect_to root_path, alert: "You are already logged in using #{logintime.browser_info}"
  end
  def check_browser
    user_agent = UserAgent.parse(request.user_agent)
  end

end

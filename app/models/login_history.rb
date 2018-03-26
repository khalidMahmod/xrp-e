require 'bcrypt'
require 'securerandom'

class LoginHistory < ActiveRecord::Base
    belongs_to :member

  def self.insert(member, locationinfo, useragent)
      @login_history = LoginHistory.new
      @login_history.member_id= member.id
      @login_history.user_agent =useragent
      @login_history.browser_info =useragent.browser
      @login_history.login_time = Time.now
      @login_history.ip_address = locationinfo["query"]
      @login_history.location = locationinfo["countryCode"]
      @login_history.save
  end

  def self.create_user_signature(member, locationinfo, useragent)
    rs = SecureRandom.hex
    sign_params = "#{member.email}:#{locationinfo["query"]}:#{locationinfo["zip"]}:#{locationinfo["countryCode"]}:#{Time.now.to_s}:#{rs}"
    sign = BCrypt::Password.create(sign_params)
    if member.signature.present? && (member.signature == sign)
       member.increment(:is_disabled, 1) unless member.is_disabled == Member::DISABLED_PERMANENTLY
       member.update_attribute(:disable_time, Time.now)
       false
    else
       member.update_attribute(:signature, sign)
       sign
    end
  end
end

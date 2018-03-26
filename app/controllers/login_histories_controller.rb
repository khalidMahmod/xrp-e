require 'httparty'
class LoginHistoriesController < ApplicationController
  before_action :auth_member!
  layout "landing"

  def index
        if current_user.present?
          @login_histories = LoginHistory.where(member_id: current_user.id)
                            .order('created_at DESC').paginate(:page => params[:page], :per_page => 10)

        else
    end
  end

end

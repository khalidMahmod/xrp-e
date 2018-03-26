class TopController < ApplicationController
  def logout
    MemberMfaSession.destroy
    redirect_to :root
  end
end
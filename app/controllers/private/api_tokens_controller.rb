require 'openssl'
#require 'Base64'

module Private
  class APITokensController < BaseController
    before_action :auth_verified!

    def index
      @tokens = current_user.api_tokens
      @access_key = "$2a$10$Hnmxe.yQJRsC26P9xMQME.NgD9TStSBijiR3kD8i2sBUMSXvzhAkG"
      @access_secret = "$2a$10$K8YSWl0MRQNsvs26YoH1p.9idChikIB3Rn53C5DMQsrVZrRNYC60C"
      @time = (Time.now.to_f * 1000).to_i
      @payload = "GET|/api/v2/markets|access_key=#{@access_key}&tonce=#{@time}"
      @signature = OpenSSL::HMAC.hexdigest 'SHA256', @access_secret, @payload
      ids = APIToken.select('max(id) as id')
      @access_tokens = APIToken.where(id: ids)
    end

    def new
      @token = current_user.api_tokens.build
    end

    def create
      @token = current_user.api_tokens.build api_token_params
      @token.scopes = 'all'

      if @token.save
        flash.now[:notice] = t('.success')
      else
        flash.now[:alert] = t('.failed')
        render :new
      end
    end

    def edit
      @token = current_user.api_tokens.find params[:id]
    end

    def update
      @token = current_user.api_tokens.find params[:id]

      if @token.update_attributes(api_token_params)
        flash.now[:notice] = t('.success')
      else
        flash.now[:alert] = t('.failed')
      end

      render :edit
    end

    def destroy
      @token = current_user.api_tokens.find params[:id]
      if @token.destroy
        redirect_to url_for(action: :index), notice: t('.success')
      else
        redirect_to url_for(action: :index), notice: t('.failed')
      end
    end

    private

    def api_token_params
      params.require(:api_token).permit(:label, :ip_whitelist)
    end

  end
end

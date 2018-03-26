module Admin
  class DashboardController < BaseController
    skip_load_and_authorize_resource

    def index
      @currencies_summary = Currency.all.map(&:summary)
      @register_count = Member.count
      @server = system "god status"
      @result = `god status`
      @status = @result.split(' ')
    end
    def daemon_start
      system "god -c lib/daemons/daemons.god"
      redirect_to admin_dashboard_path
    end
    def daemon_stop
      system "god terminate"
      redirect_to admin_dashboard_path
    end
    def individual_daemon_stop
      @daemon_name = params[:daemon_name]
      @server = system "god status"
      @result = `god status`
      @status = @result.split(' ')
      status = @status[params[:index].to_i+1]
      daemon_name= @daemon_name.chop
      system "god stop #{daemon_name}"
      while  @server && status == @status[params[:index].to_i+1]
        @server = system "god status"
        @result = `god status`
        @status = @result.split(' ')
      end
      if status == @status[params[:index].to_i+1]
        flash[:warning] = "Something's wrong"
      end
      redirect_to admin_dashboard_path
    end
    def individual_daemon_start
      @daemon_name = params[:daemon_name]
      @server = system "god status"
      @result = `god status`
      @status = @result.split(' ')
      status = @status[params[:index].to_i+1]
      daemon_name= @daemon_name.chop
      system "god start #{daemon_name}"
      while  @server && status == @status[params[:index].to_i+1]
        @server = system "god status"
        @result = `god status`
        @status = @result.split(' ')
      end
      if status == @status[params[:index].to_i+1]
        flash[:warning] = "Something's wrong"
      end
      redirect_to admin_dashboard_path
    end
  end
end

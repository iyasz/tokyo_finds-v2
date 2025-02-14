class Admin::DashboardController < ApplicationController
  layout "admin"

  def index
    @sidebarType = "dashboard"
  end

end

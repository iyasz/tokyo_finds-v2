class Admin::ProductController < ApplicationController
  layout "admin"

  def index
    @sidebarType = "manage"
  end

  def create
    @sidebarType = "manage"
    render "admin/product/create"
  end

end

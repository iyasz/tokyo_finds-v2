class Admin::ProductController < ApplicationController
  layout "admin"

  def index
    @category = "manage"
  end

  def create
    @category = "manage"
    render "admin/product/create"
  end

end

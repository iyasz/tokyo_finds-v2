class Admin::CategoryController < ApplicationController
  layout "admin"

  def index
    @sidebarType = "manage"
    per_page = 2
    page = params[:page].to_i > 0 ? params[:page].to_i : 1
    offset = (page - 1) * per_page

    @categories = Category.limit(per_page).offset(offset)
    @total_pages = (Category.count.to_f / per_page).ceil
    @current_page = page
  end

  def new
    @sidebarType = "manage"
    @category = Category.new

  end

  def create
    @sidebarType = "manage"
    @category = Category.new(category_params)

    if @category.save
      flash[:success] = "Category berhasil dibuat!"
      redirect_to "/app/categories"
    else
      flash[:error] = @category.errors.full_messages.first
      redirect_to "/app/categories/new"
    end
  end

  def edit
    @sidebarType = "manage"
    @category = Category.find_by(id: params[:id])

    if @category.nil?
      render_not_found
    end
  end

  def update
    @sidebarType = "manage"
    @category = Category.find_by(id: params[:id])
    if @category.nil?
      render_not_found
    end

    if @category.update(category_params)
      flash[:success] = "Category berhasil diubah"
      redirect_to "/app/categories"
    else
      flash[:error] = @category.errors.full_messages.first
      redirect_back fallback_location: "/app/categories"
    end
  end

  def destroy
    @category = Category.find_by(id: params[:id])
    if @category.nil?
      render_not_found
    end

    if @category.destroy
      flash[:success] = "Category berhasil dihapus!"
      redirect_to "/app/categories"
    else
      flash[:error] = "Terjadi kesalahan!"
      redirect_to "/app/categories"
    end
  end

  private

  def category_params
    params.permit(:name, :before_cover, :after_cover)
  end
end

class Admin::BrandController < ApplicationController
  layout "admin"

  def index
    @sidebarType = "manage"
    per_page = 10
    page = params[:page].to_i > 0 ? params[:page].to_i : 1
    offset = (page - 1) * per_page
  
    @brands = Brand.limit(per_page).offset(offset).order(:created_at)
    @total_pages = (Brand.count.to_f / per_page).ceil
    @current_page = page
  end

  def new
    @sidebarType = "manage"
    @brand = Brand.new
  end

  def create
    @sidebarType = "manage"
    @brand = Brand.new(brand_params)
    if @brand.save
      flash[:success] = "Brand berhasil dibuat!"
      redirect_to "/app/brands"
    else
      flash[:error] = @brand.errors.full_messages.first
      redirect_to "/app/brands/new"
    end
  end

  def edit
    @sidebarType = "manage"
    @brand = Brand.find_by(id: params[:id])

    if @brand.nil?
      render_not_found
    end
  end

  def update
    @sidebarType = "manage"
    @brand = Brand.find_by(id: params[:id])
    if @brand.nil?
      render_not_found
    end

    if @brand.update(brand_params)
      flash[:success] = "Brand berhasil diubah"
      redirect_to "/app/brands"
    else
      flash[:error] = @brand.errors.full_messages.first
      redirect_back fallback_location: "/app/brands"
    end
  end

  def destroy
    @brand = Brand.find_by(id: params[:id])
    if @brand.nil?
      render_not_found
    end

    if @brand.destroy
      flash[:success] = "Brand berhasil dihapus!"
      redirect_to "/app/brands"
    else
      flash[:error] = "Terjadi kesalahan!"
      redirect_to "/app/brands"
    end
  end

  private

  def brand_params
    params.permit(:name)
  end

end

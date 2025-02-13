class Admin::BrandController < ApplicationController
  layout "admin"

  def index
    @category = "manage"
    per_page = 5
    page = params[:page].to_i > 0 ? params[:page].to_i : 1
    offset = (page - 1) * per_page
  
    @brands = Brand.limit(per_page).offset(offset)
    @total_pages = (Brand.count.to_f / per_page).ceil
    @current_page = page
  end

  def new
    @category = "manage"
    @brand = Brand.new
  end

  def create
    @category = "manage"
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
    @category = "manage"
    @brand = Brand.find_by(id: params[:id])

    if @brand.nil?
      render_not_found
    end
  end

  def update
    @category = "manage"
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

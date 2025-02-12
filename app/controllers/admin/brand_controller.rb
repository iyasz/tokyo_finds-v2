class Admin::BrandController < ApplicationController
  layout "admin"

  def index
    @category = "manage"
  end

  def new
    @category = "manage"
    @brand = Brand.new
  end

  def create
    @brand = Brand.new(brand_params)
    if @brand.save
      flash[:success] = "Brand berhasil dibuat!"
      redirect_to "/app/brands"
    else
      flash[:success] = "Brand gagal dibuat!"
      redirect_to "/app/brands"
    end
  end

  def edit
    @brand = Brand.find(params[:id])
  end

  def update
    @brand = Brand.find(params[:id])
    if @brand.update(brand_params)
      redirect_to admin_brands_path, notice: "Brand berhasil diperbarui."
    else
      render :edit
    end
  end

  def destroy
    @brand = Brand.find(params[:id])
    @brand.destroy
    redirect_to admin_brands_path, notice: "Brand berhasil dihapus."
  end

  private

  def brand_params
    params.permit(:name)
  end

end

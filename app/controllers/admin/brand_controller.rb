class Admin::BrandController < ApplicationController
  layout "admin"

  def index
    @category = "manage"
    @brands = Brand.order(:created_at).page(params[:page]).per(5)
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
      flash.now[:error] = @brand.errors.full_messages.first
      render :"admin/brand/new", status: :unprocessable_entity
    end
  end

  def edit
    @brand = Brand.find_by(id: params[:id])

    if @brand.nil?
      render_not_found
    end
  end

  def update
    @brand = Brand.find_by(id: params[:id])
    if @brand.nil?
      render_not_found
    end

    if @brand.update(brand_params)
      flash[:success] = "Brand berhasil diubah"
      redirect_to "/app/brands"
    else
      flash.now[:error] = @brand.errors.full_messages.first
      render :edit, status: :unprocessable_entity
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

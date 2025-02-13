class Admin::SeriesController < ApplicationController
  layout "admin"

  def index
    @category = "manage"
    per_page = 5
    page = params[:page].to_i > 0 ? params[:page].to_i : 1
    offset = (page - 1) * per_page

    @series = Series.limit(per_page).offset(offset)
    @total_pages = (Series.count.to_f / per_page).ceil
    @current_page = page
  end

  def new
    @category = "manage"
    @series = Series.new
  end

  def create
    @series = Series.new(series_params)
    if @series.save
      flash[:success] = "Series berhasil dibuat!"
      redirect_to "/app/series"
    else
      flash.now[:error] = @series.errors.full_messages.first
      render :"admin/series/new", status: :unprocessable_entity
    end
  end

  def edit
    @category = "manage"
    @series = Series.find_by(id: params[:id])

    if @series.nil?
      render_not_found
    end
  end

  def update
    @series = Series.find_by(id: params[:id])
    if @series.nil?
      render_not_found
    end

    if @series.update(series_params)
      flash[:success] = "Series berhasil diubah"
      redirect_to "/app/series"
    else
      flash.now[:error] = @series.errors.full_messages.first
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @series = Series.find_by(id: params[:id])
    if @series.nil?
      render_not_found
    end

    if @series.destroy
      flash[:success] = "Series berhasil dihapus!"
      redirect_to "/app/series"
    else
      flash[:error] = "Terjadi kesalahan!"
      redirect_to "/app/series"
    end
  end

  private

  def series_params
    params.permit(:name)
  end

end

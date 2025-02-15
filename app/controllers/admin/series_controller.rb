class Admin::SeriesController < ApplicationController
  layout "admin"

  def index
    @sidebarType = "manage"
    per_page = 5
    page = params[:page].to_i > 0 ? params[:page].to_i : 1
    offset = (page - 1) * per_page

    @series = Series.limit(per_page).offset(offset).order(:created_at)
    @total_pages = (Series.count.to_f / per_page).ceil
    @current_page = page
  end

  def new
    @sidebarType = "manage"
    @series = Series.new
  end

  def create
    @sidebarType = "manage"
    @series = Series.new(series_params)
    if @series.save
      flash[:success] = "Series berhasil dibuat!"
      redirect_to "/app/series"
    else
      flash[:error] = @series.errors.full_messages.first
      redirect_to "/app/series/new"
    end
  end

  def edit
    @sidebarType = "manage"
    @series = Series.find_by(id: params[:id])

    if @series.nil?
      render_not_found
    end
  end

  def update
    @sidebarType = "manage"
    @series = Series.find_by(id: params[:id])
    if @series.nil?
      render_not_found
    end

    if @series.update(series_params)
      flash[:success] = "Series berhasil diubah"
      redirect_to "/app/series"
    else
      flash[:error] = @series.errors.full_messages.first
      redirect_back fallback_location: "/app/series"
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

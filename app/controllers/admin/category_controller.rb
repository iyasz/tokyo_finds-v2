class Admin::CategoryController < ApplicationController
  layout "admin"

  def index
    @sidebarType = "manage"
    per_page = 2
    page = params[:page].to_i > 0 ? params[:page].to_i : 1
    offset = (page - 1) * per_page

    @categories = Category.limit(per_page).offset(offset).order(:created_at)
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
      flash.now[:error] = @category.errors.full_messages.first
      render :new
    end
  end

  def edit
    @sidebarType = "manage"
    @category = Category.find_by(id: params[:id])

    return render_not_found if @category.nil?
  end

  def update
    @sidebarType = "manage"
    @category = Category.find_by(id: params[:id])
    return render_not_found if @category.nil?

    # Validasi Ke Model 
    temp_category = @category.clone
    temp_category.assign_attributes(category_params)

    unless temp_category.valid?
      flash[:error] = temp_category.errors.full_messages.first
      return redirect_back fallback_location: "/app/categories"
    end

    ActiveRecord::Base.transaction do
      if params[:before_cover].present? && @category.before_cover.attached?
        file_path = ActiveStorage::Blob.service.path_for(@category.before_cover.key)
        @category.before_cover.purge
        cleanup_empty_folders(file_path, 2)
      end

      if params[:after_cover].present? && @category.after_cover.attached?
        file_path = ActiveStorage::Blob.service.path_for(@category.after_cover.key)
        @category.after_cover.purge
        cleanup_empty_folders(file_path, 2)
      end

      if @category.update(category_params)
        flash[:success] = "Category berhasil diubah"
        redirect_to "/app/categories"
      else
        flash[:error] = @category.errors.full_messages.first
        redirect_back fallback_location: "/app/categories"
      end
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

  def cleanup_empty_folders(file_path, levels)
    folder = File.dirname(file_path)

    levels.times do
      break if folder == Rails.root.join("storage")
      Dir.rmdir(folder) if Dir.exist?(folder) && Dir.empty?(folder) rescue nil
      folder = File.dirname(folder)
    end
  end

end

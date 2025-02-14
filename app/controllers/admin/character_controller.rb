class Admin::CharacterController < ApplicationController
  layout "admin"

  def index
    @sidebarType = "manage"
    per_page = 5
    page = params[:page].to_i > 0 ? params[:page].to_i : 1
    offset = (page - 1) * per_page

    @characters = Character.limit(per_page).offset(offset)
    @total_pages = (Character.count.to_f / per_page).ceil
    @current_page = page
  end

  def new
    @sidebarType = "manage"
    @character = Character.new
  end

  def create
    @sidebarType = "manage"
    @character = Character.new(character_params)
    if @character.save
      flash[:success] = "Character berhasil dibuat!"
      redirect_to "/app/characters"
    else
      flash[:error] = @character.errors.full_messages.first
      redirect_to "/app/characters/new"
    end
  end

  def edit
    @sidebarType = "manage"
    @character = Character.find_by(id: params[:id])

    if @character.nil?
      render_not_found
    end
  end

  def update
    @sidebarType = "manage"
    @character = Character.find_by(id: params[:id])
    if @character.nil?
      render_not_found
    end

    if @character.update(character_params)
      flash[:success] = "Character berhasil diubah"
      redirect_to "/app/characters"
    else
      flash[:error] = @character.errors.full_messages.first
      redirect_back fallback_location: "/app/characters"
    end
  end

  def destroy
    @character = Character.find_by(id: params[:id])
    if @character.nil?
      render_not_found
    end

    if @character.destroy
      flash[:success] = "Character berhasil dihapus!"
      redirect_to "/app/characters"
    else
      flash[:error] = "Terjadi kesalahan!"
      redirect_to "/app/characters"
    end
  end

  private

  def character_params
    params.permit(:name)
  end
end

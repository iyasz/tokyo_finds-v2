class Admin::CharacterController < ApplicationController
  layout "admin"

  def index
    @category = "manage"
    per_page = 5
    page = params[:page].to_i > 0 ? params[:page].to_i : 1
    offset = (page - 1) * per_page

    @characters = Character.limit(per_page).offset(offset)
    @total_pages = (Character.count.to_f / per_page).ceil
    @current_page = page
  end

  def new
    @category = "manage"
    @character = Character.new
  end

  def create
    @character = Character.new(character_params)
    if @character.save
      flash[:success] = "Character berhasil dibuat!"
      redirect_to "/app/characters"
    else
      flash.now[:error] = @character.errors.full_messages.first
      render :"admin/character/new", status: :unprocessable_entity
    end
  end

  def edit
    @character = Character.find_by(id: params[:id])

    if @character.nil?
      render_not_found
    end
  end

  def update
    @character = Character.find_by(id: params[:id])
    if @character.nil?
      render_not_found
    end

    if @character.update(character_params)
      flash[:success] = "Character berhasil diubah"
      redirect_to "/app/characters"
    else
      flash.now[:error] = @character.errors.full_messages.first
      render :edit, status: :unprocessable_entity
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

class AlbumsController < ApplicationController
    # GET albums/new
    def new
        @album = Album.new
    end

    # POST albums/new
    def create
        @album = Album.create(name: params[:album][:name], user_id: params[:album][:user_id])

        params[:album][:images].each do |img|
            Picture.create!(image: img, album_id: @album.id, user_id: params[:album][:user_id])
        end

        respond_to do |format|
            if @album.save
                format.html { redirect_to root_path, notice: 'Album was successfully uploaded.' }
                format.json { render :index, status: :created, location: @album }
            else
                format.html { render :new }
                format.json { render json: @album.errors, status: :unprocessable_entity }
            end
        end
    end

    # GET albums/:id
    def index
        if user_signed_in?
            @albums = current_user.albums.order(created_at: :desc)
        end
    end

    # GET albums/:id/pictures
    def show
        @album = Album.find(params[:id])
        @pictures = Picture.where(album_id: @album.id)
    end

    # DELETE albums/:id
    def destroy
        @album = Album.find(params[:id])
        @album.destroy

        respond_to do |format|
            format.html { redirect_to root_path, notice: 'Picture was successfully deleted.' }
            format.json { head :no_content }
        end
    end

    private
        def album_params
            params.require(:album).permit(:user_id, :name, images: [])
        end
end

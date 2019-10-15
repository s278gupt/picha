class AlbumsController < ApplicationController
    # GET albums/new
    def new
        @album = Album.new
    end

    # POST albums/new
    def create
        @album = Album.create!(name: params[:album][:name], user_id: params[:album][:user_id])

        params[:album][:images].each do |img|
            Picture.create!(image: img, album_id: @album.id, user_id: params[:album][:user_id])
        end

        respond_to do |format|
            format.html { redirect_to pictures_path, notice: 'Picture was successfully deleted.' }
            format.json { head :no_content }
        end
    end

    private
        def album_params
            params.require(:album).permit(:user_id, :name, images: [])
        end
end

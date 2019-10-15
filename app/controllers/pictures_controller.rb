class PicturesController < ApplicationController
    before_action :set_picture, only: [:destroy, :edit, :update]

    # GET pictures/new
    def new
        @picture = Picture.new
    end

    # POST pictures/new
    def create
        @picture = Picture.new(picture_params)

        if !picture_params[:album_id]
            @picture.album_id = nil
        end

        respond_to do |format|
            if @picture.save
                format.html { redirect_to pictures_path, notice: 'Picture was successfully uploaded.' }
                format.json { render :index, status: :created, location: @picture }
            else
                format.html { render :new }
                format.json { render json: @picture.errors, status: :unprocessable_entity }
            end
        end
    end

    # GET pictures/:id
    def index
        if user_signed_in?
            @pictures = current_user.pictures.order(created_at: :desc)
        end
    end

    # DELETE pictures/:id
    def destroy
        @picture.destroy

        respond_to do |format|
            format.html { redirect_to pictures_path, notice: 'Picture was successfully deleted.' }
            format.json { head :no_content }
        end
    end

    # GET pictures/:id/edit
    def edit
    end

    private
        def set_picture
            @picture = current_user.pictures.find(params[:id])   
        end

        def picture_params
            params.require(:picture).permit(:user_id, :image, :album_id)
        end
end

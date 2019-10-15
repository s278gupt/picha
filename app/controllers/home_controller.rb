class HomeController < ApplicationController
  def index
    if user_signed_in?
      @albums = current_user.albums.order(created_at: :desc)
      @pictures = current_user.pictures.order(created_at: :desc)
    end
  end
end

class HomeController < ApplicationController
  def index
    if user_signed_in?
      @pictures = current_user.pictures.order(created_at: :desc)
    end
  end
end

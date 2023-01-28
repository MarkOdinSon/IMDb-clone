class ApplicationController < ActionController::Base
  before_action :set_array_names_of_movie
  include Pundit::Authorization

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private

  def set_array_names_of_movie
    @array_names_of_movie = Movie.all.select(:title).map(&:title).uniq
  end

  def user_not_authorized
    if current_user
      flash[:alert] = "You don't have enough rights to access it :("
      redirect_to(request.referrer || root_path)
    else
      flash[:alert] = "Sign in before continuing!"
      redirect_to new_user_session_path
    end
  end
end

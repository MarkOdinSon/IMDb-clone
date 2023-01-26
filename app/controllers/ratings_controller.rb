class RatingsController < ApplicationController
  # skip_before_action :verify_authenticity_token (uncomment it in the case if you don't have csrf-token)

  def create
    flash[:alert] = "Create rating"

    Movie.find(50).update(rating: 5)

    respond_to do |format|
      format.turbo_stream {
        render turbo_stream: turbo_stream.replace("my_turbo_frame_50",
                                                  render_to_string( partial: 'movies/rating', locals: { movie: Movie.find(50) }) )
      }

      format.html { redirect_to (request.referrer || root_path) }
    end
  end

  def update
    flash[:alert] = "Update rating"

  end

  def destroy
    flash[:alert] = "Destroy rating"

  end
end

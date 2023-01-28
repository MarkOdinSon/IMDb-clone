class RatingsController < ApplicationController
  # skip_before_action :verify_authenticity_token (uncomment it in the case if you don't have csrf-token)
  # [https://fly.io/ruby-dispatch/turbostream-fetch/]

  def create
    Rating.create(post_params)

    recalculate_average_rating(post_params[:movie_id])

    respond_with_turbo_stream(post_params[:movie_id])
  end

  def update
    Rating.where(movie_id: post_params[:movie_id], user_id: post_params[:user_id]).update(grade: post_params[:grade])

    recalculate_average_rating(post_params[:movie_id])

    respond_with_turbo_stream(post_params[:movie_id])
  end

  def destroy
    Rating.where(movie_id: post_params[:movie_id], user_id: post_params[:user_id]).first.delete

    recalculate_average_rating(post_params[:movie_id])

    respond_with_turbo_stream(post_params[:movie_id])
  end

  private

  def recalculate_average_rating(movie_id)
    sum = 0.0
    all_grades = Rating.where(movie_id: movie_id).map(&:grade)

    all_grades.each do |i|
      sum += i
    end

    begin
      return Movie.find(movie_id).update(rating: (sum / all_grades.count).round(1)) if all_grades.count.positive?

      Movie.find(movie_id).update(rating: 0)
    rescue StandardError
      redirect_to root_path, flash: { alert: 'Something went wrong in function calculate average rating! Contact the developer!' }
    end
  end

  def respond_with_turbo_stream(movie_id)
    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.replace("turbo_frame_show_movie_rating_inf_#{post_params[:movie_id]}",
                                                  render_to_string(partial: 'movies/rating',
                                                                   locals: { movie: Movie.find(post_params[:movie_id]) }))
      end
    end
  end

  # Only allow a list of trusted parameters through.
  def post_params
    params.require(:rating).permit(:user_id, :movie_id, :grade)
  end
end

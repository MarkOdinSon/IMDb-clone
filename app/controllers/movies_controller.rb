class MoviesController < ApplicationController
  def index
    @movies = Movie.all.order(id: :desc).page(params[:page])
  end

  def show
    begin
      @movie = Movie.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      redirect_to root_path, flash: { alert: "Oops, movie with id: #{params[:id]} not found!" }
    end
  end
end

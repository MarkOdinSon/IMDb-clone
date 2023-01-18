class MoviesController < ApplicationController
  before_action :get_movie_by_id, only: %i[show edit update destroy]

  def index
    @movies = Movie.all
  end

  def show; end

  def new; end

  def create; end

  def edit; end

  def update; end

  def destroy; end

  private

  def get_movie_by_id
    @movie = Movie.find(params[:id])
  end
end

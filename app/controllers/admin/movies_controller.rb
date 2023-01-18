class Admin::MoviesController < ApplicationController
  before_action :get_movie_by_id, only: %i[edit update destroy]

  def new
    authorize :movie, :new?
    render flash: 'Hi, Admin. Let`s add a new movie!'
  end

  def create
    authorize :movie, :craete?


  end

  def edit
    authorize :movie, :edit
    render flash: 'Hi, Admin. Here you can edit an existing movie!'
  end

  def update
    authorize :movie, :update


  end

  def destroy
    authorize :movie, :destroy


  end

  private

  def get_movie_by_id
    @movie = Movie.find(params[:id])
  end
end

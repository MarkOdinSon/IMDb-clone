class MoviesController < ApplicationController
  def index
    @movies = Movie.all.order(id: :desc).page(params[:page])

    @movies = unless params[:category].nil?


    @movies = Movie.search_movies_by_title(params[:title]).page(params[:page]) unless params[:title].nil?
  end

  def show
    begin
      @movie = Movie.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      redirect_to root_path, flash: { alert: "Oops, movie with id: #{params[:id]} not found!" }
    end
  end

  def set_search_and_filter_options

    s = Category.where(id: params[:category_ids]).map(&:name)

    redirect_to "/?category=#{s}&title=#{params[:title]}"
  end
end

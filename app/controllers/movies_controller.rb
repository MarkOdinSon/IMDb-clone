class MoviesController < ApplicationController
  def index
    categories = params[:category]
    title = params[:title]
    page = params[:page]

    # There are three variants of search:
    # 1. First one is standard, When both are missing (no search and no filter) so must return all Movie
    # 2. Second one is When there is only title and there are no categories
    # 3. Third one is When there are both (categories and title)
    # 4. First one is When there are only categories and there is no title

    # here variant #1
    return @movies = Movie.all.order(id: :desc).page(page) if (categories == '' && title == '') || (categories.nil? && title.nil?)

    # here variant #2
    return @movies = Movie.search_movies_by_categories(categories).page(page) if categories != '' && title == ''

    # here variant #3
    return @movies = Movie.search_movies_by_title(title).page(page) if title != '' && categories == ''

    # here variant #4
    @movies = Movie.search_movies_by_categories(categories)
    @movies = @movies.where(id: Movie.search_movies_by_title(title).ids).page(page)
  end

  def show
    begin
      @movie = Movie.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      redirect_to root_path, flash: { alert: "Oops, movie with id: #{params[:id]} not found!" }
    end
  end

  def set_search_option
    string_with_array_of_categories = Category.where(id: params[:category_ids]).map(&:name).join(', ').delete(' ')

    redirect_to "/?category=#{string_with_array_of_categories}&title=#{params[:title]}"
  end
end

class Admin::MoviesController < ApplicationController
  before_action :get_movie_by_id, only: %i[edit update destroy]

  def new
    authorize :movie, :new?
    flash[:notice] = 'Hi, Admin. Let`s add a new movie!'

    @movie = Movie.new
  end

  def create
    authorize :movie, :create?

    authorize :movie, :create?

    @movie = Movie.create(title: 'title', text: 'text')

    respond_to do |format|
      if @movie.update(post_params)
        format.html { redirect_to @movie, notice: 'Movie was successfully created!' }
        format.json { render :show, status: :ok, location: @movie }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @movie.errors, status: :unprocessable_entity }
      end
    end

    # so for some reason it does not want to create records
    # @movie = Movie.new(post_params)

    # respond_to do |format|
    #  if @movie.save
    #    format.html { redirect_to @movie, notice: 'New movie was successfully created!' }
    #    format.json { render :show, status: :created, location: @movie }
    #  else
    #    format.html { render :new, status: :unprocessable_entity }
    #    format.json { render json: @movie.errors, status: :unprocessable_entity }
    #  end
    # end
    #
  end

  def edit
    authorize :movie, :edit
    flash[:notice] = 'Hi, Admin. Here you can edit an existing movie!'
  end

  def update
    authorize :movie, :update

    respond_to do |format|
      if @movie.update(post_params)
        format.html { redirect_to @movie, notice: 'Movie was successfully updated!' }
        format.json { render :show, status: :ok, location: @movie }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @movie.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    authorize :movie, :destroy


  end

  private

  def get_movie_by_id
    begin
      @movie = Movie.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      if current_user
        unless current_user.role == 'user'
          redirect_to root_path, flash: { alert: "Oops, movie with id: #{params[:id]} not found!" }
        end
      end
    end
  end

  # Only allow a list of trusted parameters through.
  def post_params
    params.require(:movie).permit(:title, :text, :image, category_ids: [])
  end
end

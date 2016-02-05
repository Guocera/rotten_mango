class MoviesController < ApplicationController
  def index
    @movies = Movie.all
    @movies = @movies.search_by_title(params[:title]) if params[:title]
    @movies = @movies.search_by_director(params[:director]) if params[:director]
    case runtime_in_minutes = params[:runtime_in_minutes]
    when "90"
      @movies = @movies.where(
       "runtime_in_minutes < :runtime_in_minutes",
       runtime_in_minutes: runtime_in_minutes
      )
    when "120"
      @movies = @movies.where(
        "runtime_in_minutes > :min AND runtime_in_minutes < :max", 
        min: 90, max: 120
      )
    when "121"
      @movies = @movies.where(
       "runtime_in_minutes > :runtime_in_minutes",
       runtime_in_minutes: runtime_in_minutes
      )
    end


  end

  def show
    @movie = Movie.find(params[:id])
  end

  def new
    @movie = Movie.new
  end

  def edit
    @movie = Movie.find(params[:id])
  end

  def create
    @movie = Movie.new(movie_params)

    if @movie.save
      redirect_to movies_path, notice: "#{@movie.title} was submitted successfully!"
    else
      render :new
    end
  end

  def update
    @movie = Movie.find(params[:id])

    if @movie.update_attributes(movie_params)
      redirect_to movie_path(@movie)
    else
      render :edit      
    end
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    redirect_to movies_path
  end

  protected

  def movie_params
    params.require(:movie).permit(
      :title, 
      :release_date, 
      :director, 
      :runtime_in_minutes, 
      :image, 
      :remote_image_url,
      :description,
      :commit
    )
  end
end

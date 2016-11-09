class MoviesController < ApplicationController
  
 # before_filter :has_authenticate?, :only =>[:new,:create,:edit,:update,:destroy]
  
  def has_authenticate?
      unless @current_user1
        flash[:warning]="You must be logged in to obtain the rights"
        redirect_to movies_path 
        return
      end
  end
  
  def movies_with_filters
    @movie=Movie.with_good_reviews(params[:threshold])
    @movie=@movie.for_kids   if params[:for_kids]
    @movie=@movie.with_many_fans  if params[:with_many_fans]
    @movie=@movie.recently_reviewed if params[:recently_reviewed]
  end
    
  def index
    @movies = Movie.all
    @movies=@movies.sort_by do |value|
      value.title
    end
  end
  
  def show
    begin 
      id= params[:id]
      @movie=Movie.find(id)
      render(:partial => 'movie',:object => @movie) and return if request.xhr?
    rescue ActiveRecord::RecordNotFound
      flash[:warning]="Sorry,no movie with the given ID could be found"
      redirect_to movies_path
    end
  end
  
  def new
    @movie=Movie.new
  end
  
  def create
    @movie=Movie.new(movie_params)
    
    if @movie.save
      flash[:notice]="#{@movie.title} was successfully created"
      redirect_to movie_path(@movie)
    else
      render 'new'
    end
  end
  
  def edit
    @movie =Movie.find(params[:id])
  end
  
  def update
    @movie = Movie.find(params[:id])
    if @movie.update_attributes(movie_params)
      flash[:notice]="#{@movie.title} was successfully updated"
      redirect_to movie_path(@movie)
    else
      render 'edit'
    end
  end
  
  def destroy 
    @movie =Movie.find(params[:id])
    flash[:notice]="Movie #{@movie.title} deleted"
    @movie.destroy
    redirect_to movies_path
  end
  
  private
  def movie_params
  return  params.require(:movie).permit(:title,:rating,:release_date)
  end
end
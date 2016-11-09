class ReviewsController < ApplicationController
  
  before_filter :has_moviegoer_and_movie, :only =>[:new,:create]
  
  public 
  def new 
    @review = @movie.reviews.build
  end
  
  def create
    @current_user1.reviews << @movie.reviews.build(review_params)
    redirect_to movie_path(@movie)
  end
  
  protected 
  def has_moviegoer_and_movie
    
    unless @current_user1
      flash[:warning]="You must be logged in to create a review"
      redirect_to movies_path
      return 
    end
    
    unless (@movie =Movie.find_by_id(params[:movie_id]))
      flash[:warning]='Review must be for an exsiting movie'
      redirect_to  movies_path and return
    end  
  end
  
  private
  def review_params
  return  params.require(:movie).permit(:review)
  end
  
end

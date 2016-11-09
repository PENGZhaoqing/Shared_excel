
  class SiteController < ApplicationController


    def index
      @overview = Event::Overview.new
      respond_to do |format|
        format.html {}
        format.any { redirect_to events_path(format: params[:format]) }
      end
    end

    # Displays the about page.
    def about
    end

  end


# require "webportals/duplicate_checking/controller_actions"


class VenuesController < ApplicationController

  # include DuplicateChecking::ControllerActions
  require_admin only: [:duplicates, :squash_many_duplicates]

  def venue
    @venue ||= params[:id] ? Venue.find(params[:id]) : Venue.new
  end

  # GET /venues
  def index
    # 0> params.permit!
    # => {"controller"=>"calagator/venues", "action"=>"index"}
    @search = Venue::Search.new(params.permit!)
    #@ search => #<struct Calagator::Venue::Search tag=nil, query=nil, wifi=nil, all=nil, closed=nil, include_closed=nil>
    @venues = @search.venues

    flash[:failure] = @search.failure_message unless @search.failure_message.nil?

    # venues_path => "/venues"
    return redirect_to venues_path if @search.hard_failure?

  end


  # GET /autocomplete via AJAX
  def autocomplete
    @venues = Venue
                  .non_duplicates
                  .in_business
                  .where(["LOWER(title) LIKE ?", "%#{params[:term]}%".downcase])
                  .order('LOWER(title)')

    render json: @venues
  end


  # GET /venues/map
  def map

  end


  # GET /venues/1
  def show
    venue
  end


  # GET /venues/new
  def new
    venue
  end


  # GET /venues/1/edit
  def edit
    venue
  end

  # PUT /venues/1
  def update
    update_or_create
  end

  # POST /venues,
  def create
    @venue=Venue.new
    update_or_create
  end

  def update_or_create
    saver=Venue::Saver.new(@venue, params.permit!)
    if saver.check_to_save
      if saver.save_venue
        flash[:success] = "Venue was successfully saved."
        redirect_to venue_path(@venue)
      else
        flash[:failure] = "Some unknow error occurred to prevent to save the event"
        redirect_to edit_venue_path(@venue) unless @venue.new_record?
        redirect_to new_venue_path
      end
    else
      flash[:failure]=saver.failure
      redirect_to edit_venue_path(@venue) unless @venue.new_record?
      redirect_to new_venue_path
    end
  end


  # DELETE /venues/1
  def destroy
    Destroy.new(self).call
  end

  class Destroy < SimpleDelegator
    def call
      prevent_destruction_of_venue_with_events or destroy
    end

    private

    def prevent_destruction_of_venue_with_events
      return if venue.events.none?
      message = "Cannot destroy venue that has associated events, you must reassociate all its events first."
      respond_to do |format|
        format.html { redirect_to venue, flash: {failure: message} }
        format.xml { render xml: message, status: :unprocessable_entity }
      end
    end

    def destroy
      venue.destroy
      respond_to do |format|
        format.html { redirect_to venues_path, flash: {success: %("#{venue.title}" has been deleted)} }
        format.xml { head :ok }
      end
    end
  end
end

class RepertoryDbsController < ApplicationController
  def index
    @repertory_dbs=RepertoryDb.paginate(:page => params[:page],:per_page => 11)
  end
end

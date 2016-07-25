class RepertoryDbsController < ApplicationController
  def index
    @repertory_dbs=RepertoryDb.paginate(:page => params[:page],:per_page => 20)
  end
end

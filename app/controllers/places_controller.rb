class PlacesController < ApplicationController

  def index
    @places = Place.paginate(:page => params[:page], :per_page => 1)
  end

  def new
    @place = Place.new
  end

  def create
    # Send this info to the database to make a new one
    Place.create(place_params)
    # After the create, reroute to the root index page
    redirect_to root_path
  end

  private

  def place_params
    params.require(:place).permit(:name, :description, :address)
  end

end
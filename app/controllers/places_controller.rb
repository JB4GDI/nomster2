class PlacesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]

  def index
    @places = Place.paginate(:page => params[:page], :per_page => 2)
  end

  def new
    @place = Place.new
  end

  def create
    # Send this info to the database to make a new one
    current_user.places.create(place_params)
    # After the create, reroute to the root index page
    redirect_to root_path
  end

  private

  def place_params
    params.require(:place).permit(:name, :description, :address)
  end

end
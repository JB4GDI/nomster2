class PhotosController < ApplicationController
  before_action :authenticate_user!

  def create
    # Grab the place that we are on
    @place = Place.find(params[:place_id])

    # We are creating the photo FROM the place.  Place is the starting point.  We also want to merge in the user information
    @place.photos.create(photo_params)

    # Go back to the original place page we were on
    redirect_to place_path(@place)
  end

  private

  def photo_params
    params.require(:photo).permit(:caption, :picture)
  end

end

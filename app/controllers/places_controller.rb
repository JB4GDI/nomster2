class PlacesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]

  def index
    @places = Place.paginate(:page => params[:page], :per_page => 2)
  end

  def new
    @place = Place.new
  end

  def create
    # Send this info to the database to make a new one
    @place = current_user.places.create(place_params)

    if @place.valid?
      # After the create, reroute to the root index page
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end    
  end

  def show
    # When we show, we are finding the Place with this ID (given via parameter)
    @place = Place.find(params[:id])
    @comment = Comment.new
    @photo = Photo.new
  end

  def edit
    @place = Place.find(params[:id])

    if @place.user != current_user
      return render text: 'Not allowed', status: :forbidden
    end
  end

  def update
    # Find the record the user wants to update
    @place = Place.find(params[:id])

    if @place.user != current_user
      return render text: 'Not allowed', status: :forbidden
    end

    # Update and save to the db
    @place.update_attributes(place_params)

    if @place.valid?
      # send user back to the root path
      redirect_to root_path
    else
      render :edit, status: :unprocessable_entity
    end    
  end

  def destroy
    @place = Place.find(params[:id])

    if @place.user != current_user
      return render text: 'Not allowed', status: :forbidden
    end

    @place.destroy
    redirect_to root_path
  end

  private

  def place_params
    params.require(:place).permit(:name, :description, :address)
  end

end
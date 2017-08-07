class CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @place = Place.find(params[:place_id])

    # We are creating the comment FROM the place.  Place is the starting point.  We also want to merge in the user information
    @place.comments.create(comment_params.merge(user: current_user))

    # Go back to the original place page we were on
    redirect_to place_path(@place)
  end

  private

  def comment_params
    params.require(:comment).permit(:message, :rating)
  end
end

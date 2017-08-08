class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :place
  # right after we create a new one, call this function
  after_create :send_comment_email

  # User sees what's on the left side.  Right is stored in DB.
  RATINGS = {
    'one star': '1_star',
    'two stars': '2_stars',
    'three stars': '3_stars',
    'four stars': '4_stars',
    'five stars': '5_stars'
  }

  def humanized_rating
    RATINGS.invert[self.rating]
  end

  def send_comment_email
    # Notice that this was basically what we were doing in the Rails command line
    NotificationMailer.comment_added(self).deliver
  end

end

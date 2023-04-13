class ApplicationController < ActionController::API
  before_action :set_current_user

  rescue_from Nighty::BadRequest do |exception|
    data = {
      message: exception.message
    }

    render json: data, status: :bad_request
  end

  private

  ##
  # For this demo we'll assume that the user
  # with id of 1 is the authenticated user
  #
  def set_current_user
    Current.user = User.find(1)
  end
end

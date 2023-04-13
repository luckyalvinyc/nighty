class ApplicationController < ActionController::API
  before_action :set_current_user

  {
    Nighty::BadRequest => :bad_request,
    Nighty::NotFound => :not_found
  }.each do |klass, status|
    rescue_from klass do |exception|
      data = {
        message: exception.message
      }

      render json: data, status: status
    end
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

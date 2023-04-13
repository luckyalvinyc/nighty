class V1::Users::ActivitiesController < ApplicationController
  after_action only: %i[index] do
    set_pagination_header(:activities)
  end

  def index
    @activities = user
      .activities
      .page(params[:page])
      .per(params[:per_page])

    render json: @activities.map(&:serialize)
  end

  private

  def user
    User.find(params[:user_id])
  rescue ActiveRecord::RecordNotFound
    raise User::NotFound, params[:user_id]
  end
end

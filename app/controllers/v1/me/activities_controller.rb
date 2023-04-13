class V1::Me::ActivitiesController < ApplicationController
  after_action only: %i[index] do
    set_pagination_header(:activities)
  end

  def index
    @activities = Current.user
      .activities
      .page(params[:page])
      .per(params[:per_page])

    render json: @activities.map(&:serialize)
  end
end

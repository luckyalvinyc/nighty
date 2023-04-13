class V1::Me::AnalyticsController < ApplicationController
  after_action only: %i[index] do
    set_pagination_header(:analytics)
  end

  def index
    @analytics = Analytic
      .rank_by_sleep_duration(Current.user)
      .page(params[:page])
      .per(params[:per_page])

    render json: @analytics.map(&:serialize)
  end
end

class V1::Me::SleepsController < ApplicationController
  def create
    Current.user.sleep!
    activities = Current.user.last_20_activities.map(&:serialize)

    render json: activities, status: :created
  end
end

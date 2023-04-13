class V1::Me::SleepsController < ApplicationController
  def create
    Current.user.sleep!
    activities = Current.user.last_20_activities

    render json: activities.map(&:serialize), status: :created
  end
end

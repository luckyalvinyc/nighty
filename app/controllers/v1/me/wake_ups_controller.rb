class V1::Me::WakeUpsController < ApplicationController
  def create
    activity = Current.user.wake_up!

    render json: activity.serialize
  end
end

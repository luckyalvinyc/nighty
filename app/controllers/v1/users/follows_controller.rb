class V1::Users::FollowsController < ApplicationController
  def create
    Current.user.follow!(user)

    render json: ok, status: :created
  end

  def destroy
    Current.user.unfollow!(user)

    render json: ok
  end

  private

  def user
    User.find(params[:user_id])
  rescue ActiveRecord::RecordNotFound
    raise User::NotFound, params[:user_id]
  end

  def ok
    {
      ok: true
    }
  end
end

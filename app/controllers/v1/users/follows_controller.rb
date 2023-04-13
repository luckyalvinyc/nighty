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
    @user ||= User.find_by!(id: params[:user_id])
  rescue ActiveRecord::RecordNotFound
    raise Nighty::NotFound, "User #{params[:user_id]} does not exist."
  end

  def ok
    {
      ok: true
    }
  end
end

class User < ApplicationRecord
  has_one :analytic
  has_many :activities

  has_many :followers, foreign_key: :followed_id, class_name: "Follow"
  has_many :following, foreign_key: :follower_id, class_name: "Follow"

  class NotFound < Nighty::NotFound
    def initialize(id)
      super("User #{id} does not exist.")
    end
  end

  def sleep!
    activity = latest_activity

    raise Nighty::BadRequest, "You need to wake up first before sleeping again." if activity

    activities.create(slept_at: Time.current)
  end

  def wake_up!
    latest_activity.tap do |activity|
      raise Nighty::BadRequest, "You've already woken up." if activity.nil?

      activity.woke_up_at = Time.current
      activity.save

      Analytic.record(activity)
    end
  end

  def last_20_activities
    activities
      .order(slept_at: :desc)
      .limit(20)
  end

  def follow!(other)
    raise Nighty::BadRequest, "Cannot follow self." if other.eql? self

    following.create(followed: other)
  rescue ActiveRecord::RecordNotUnique
    raise Nighty::BadRequest, "Already followed the user."
  end

  def unfollow!(other)
    record = following.find_by(followed: other)

    raise Nighty::BadRequest, "Already unfollowed the user." if record.nil?

    record.destroy!
  end

  private

  def latest_activity
    activities
      .where(woke_up_at: nil)
      .order(slept_at: :desc)
      .first
  end
end

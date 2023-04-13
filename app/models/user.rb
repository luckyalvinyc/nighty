class User < ApplicationRecord
  has_many :activities

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
    end
  end

  def last_20_activities
    activities
      .order(slept_at: :desc)
      .limit(20)
  end

  private

  def latest_activity
    activities
      .where(woke_up_at: nil)
      .order(slept_at: :desc)
      .first
  end
end

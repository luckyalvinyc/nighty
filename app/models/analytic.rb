class Analytic < ApplicationRecord
  belongs_to :user

  def self.record(activity)
    find_or_initialize_by(user: activity.user).tap do |analytic|
      analytic.duration ||= 0
      analytic.duration += (activity.woke_up_at - activity.slept_at).round

      analytic.save
    end
  end
end

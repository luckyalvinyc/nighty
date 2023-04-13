class Activity < ApplicationRecord
  belongs_to :user

  def serialize
    {
      id: id,
      slept_at: slept_at,
      woke_up_at: woke_up_at
    }
  end
end

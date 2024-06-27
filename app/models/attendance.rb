class Attendance < ApplicationRecord
  belongs_to :user
  validates :user_id, presence: true

  validates :clock_in_at, presence: true
  validate :clock_out_after_clock_in

  def clock_out_after_clock_in
    return if clock_out_at.blank? || clock_in_at.blank?
    if clock_out_at < clock_in_at
      errors.add(:clock_out_at, "must be after the clock in time")
    end
  end
end

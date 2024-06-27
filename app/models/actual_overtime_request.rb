class ActualOvertimeRequest < ApplicationRecord
  belongs_to :user

  validates :actual_start_time, presence: true
  validates :actual_end_time, presence: true
  validates :break_time, presence: true
  validates :overtime_report, presence: true
  validate :end_time_after_start_time

  def end_time_after_start_time
    return if actual_end_time.blank? || actual_start_time.blank?

    if actual_end_time < actual_start_time
      errors.add(:actual_end_time, "must be after the start time")
    end
  end
end

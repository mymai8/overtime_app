class OvertimeRequest < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :user
  belongs_to_active_hash :work_pattern

  validates :department, presence: true
  validates :work_pattern_id, presence: true
  validates :start_time, presence: true
  validates :end_time, presence: true
  validates :reason, presence: true
end

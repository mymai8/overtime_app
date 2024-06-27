class User < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :role_id, presence: true, numericality: { other_than: 1, message: "can't be blank" }
  validates :work_pattern_id, presence: true, numericality: { other_than: 1, message: "can't be blank" }

  has_many :attendances
  has_many :overtime_requests
  belongs_to_active_hash :work_pattern
  has_many :actual_overtime_requests

  def today_feed
    Attendance.where(created_at: Time.zone.today.beginning_of_day..Time.zone.today.end_of_day)
  end

  def today_attendance
    Attendance.where(created_at: Time.zone.today.beginning_of_day..Time.zone.today.end_of_day, user_id: id).first
  end
end

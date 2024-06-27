class AttendancesController < ApplicationController
  def new
    @pattern = WorkPattern.find_by(id: current_user.work_pattern_id)

    @attendance = current_user.attendances.build
    @attendances = current_user.attendances.where('created_at >= ?', Time.zone.now.beginning_of_day)

    @feed_items = current_user.today_feed.paginate(page: params[:page])

    @latest_attendance = current_user.attendances.last
    last_attendance = @attendances.last

    @is_clocked_in = clock_in?(last_attendance)
    @is_clocked_out = clock_out?(last_attendance)

  end

  def create
    @attendance = current_user.attendances.build
    last_attendance = current_user.attendances.where('created_at >= ?', Time.zone.now.beginning_of_day).last

    if last_attendance.nil? || (last_attendance.clock_in_at.present? && last_attendance.clock_out_at.present?)
      @attendance.clock_in_at = Time.zone.now
      flash[:success] = "出勤しました"
    elsif last_attendance.clock_in_at.present? && last_attendance.clock_out_at.nil?
      last_attendance.clock_out_at = Time.zone.now
      if last_attendance.save
        flash[:success] = "退勤しました"
        redirect_to new_attendance_path and return
      else
        flash[:error] = "退勤に失敗しました"
        render 'new' and return
      end
    end

    if @attendance.save
      redirect_to root_path
    else
      flash[:error] = "出勤に失敗しました"
      render 'new'
    end
  end

  def index
    @attendances = OvertimeRequest.includes(:user).all
    @pattern = WorkPattern.find_by(id: current_user.work_pattern_id)
  end

  def edit
  end

  def update
  end

  private

  def clock_in?(attendance)
    attendance.present? && attendance.clock_in_at.present? && attendance.clock_out_at.blank?
  end

  def clock_out?(attendance)
    attendance.present? && attendance.clock_out_at.present?
  end

end

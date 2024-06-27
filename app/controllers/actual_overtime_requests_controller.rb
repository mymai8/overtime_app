class ActualOvertimeRequestsController < ApplicationController
  before_action :set_actual_overtime_request, only: [:show]

  def index
    @actual_overtime_requests = ActualOvertimeRequest.all
    @overtime_data = categorize_overtime(@actual_overtime_requests)
  end

  def show
  end

  def new
    @actual_overtime_request = current_user.actual_overtime_requests.build
  end

  def create
    @actual_overtime_request = current_user.actual_overtime_requests.build(actual_overtime_request_params)
    if @actual_overtime_request.save
      redirect_to actual_overtime_requests_path
    else
      render :new
    end
  end

  def export
    set_actual_overtime_request
    respond_to do |format|
      format.xlsx {
        response.headers['Content-Disposition'] = "attachment; filename=overtime_request_#{params[:id]}.xlsx"
      }
    end
  end

  private

  def categorize_overtime(requests)
    data = {
      weekday_daytime_under_60h: 0,
      weekday_daytime_over_60h: 0,
      weekday_night_under_60h: 0,
      weekday_night_over_60h: 0,
      weekend_daytime_under_60h: 0,
      weekend_daytime_over_60h: 0,
      weekend_night_under_60h: 0,
      weekend_night_over_60h: 0
    }

    requests.each do |request|
      next unless request.actual_end_time && request.actual_start_time

      start_time = request.actual_start_time
      end_time = request.actual_end_time
      hours = (end_time - start_time) / 3600.0
      is_weekend = request.created_at.saturday? || request.created_at.sunday?
      is_night = start_time.hour < 5 || end_time.hour >= 22

      if is_weekend
        if is_night
          if hours < 60
            data[:weekend_night_under_60h] += hours
          else
            data[:weekend_night_over_60h] += hours
          end
        else
          if hours < 60
            data[:weekend_daytime_under_60h] += hours
          else
            data[:weekend_daytime_over_60h] += hours
          end
        end
      else
        if is_night
          if hours < 60
            data[:weekday_night_under_60h] += hours
          else
            data[:weekday_night_over_60h] += hours
          end
        else
          if hours < 60
            data[:weekday_daytime_under_60h] += hours
          else
            data[:weekday_daytime_over_60h] += hours
          end
        end
      end
    end

    data
  end

  def set_actual_overtime_request
    @actual_overtime_request = ActualOvertimeRequest.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to actual_overtime_requests_path, alert: 'Actual Overtime Request not found.'
  end

  def actual_overtime_request_params
    params.require(:actual_overtime_request).permit(:actual_start_time, :actual_end_time, :break_time, :overtime_report)
  end
end

class OvertimeRequestsController < ApplicationController
  before_action :set_overtime_request, only: [:show, :export]
  before_action :authenticate_user!

  def new
    @overtime_request = current_user.overtime_requests.build
    @pattern = WorkPattern.find_by(id: current_user.work_pattern_id)
    if @pattern.nil?
      flash[:alert] = '勤務パターンが見つかりません'
      redirect_to overtime_requests_path and return
    end
  end

  def create
    @overtime_request = current_user.overtime_requests.build(overtime_request_params)
    @pattern = WorkPattern.find_by(id: current_user.work_pattern_id)
    if @pattern.nil?
      flash[:alert] = '勤務パターンが見つかりません'
      render 'new' and return
    end

    if @overtime_request.save
      flash[:success] = "Overtime request submitted successfully."
      redirect_to overtime_requests_path
    else
      render 'new'
    end
  end

  def index
    @overtime_requests = current_user.overtime_requests
    @pattern = WorkPattern.find_by(id: current_user.work_pattern_id)
  end

  def show
  end

  def export
    respond_to do |format|
      format.xlsx {
        response.headers['Content-Disposition'] = "attachment; filename=overtime_request_#{params[:id]}.xlsx"
      }
    end
  end

  private

  def set_overtime_request
    @overtime_request = current_user.overtime_requests.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to overtime_requests_path, alert: 'Overtime Request not found.'
  end

  def overtime_request_params
    params.require(:overtime_request).permit(:department, :work_pattern_id, :start_time, :end_time, :reason)
  end
end

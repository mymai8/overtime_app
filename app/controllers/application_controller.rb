class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller? 
  before_action :authenticate_user!

  private

    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:email, :role_id, :work_pattern_id]) 
    end

    def clock_in?(attendance)
      return false if attendance.nil?
      !attendance.clock_in_at.nil?
    end
  
    def clock_out?(attendance)
      return false if attendance.nil?
      !attendance.clock_out_at.nil?
    end
end

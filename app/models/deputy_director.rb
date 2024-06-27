class DeputyDirector < User
  def overtime_requests
    OvertimeRequest.where(user_id: id)
  end
end

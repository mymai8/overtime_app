class DeputyDirectorsController < ApplicationController
  before_action :set_deputy_director, only: [:show]

  def index
    @deputy_directors = User.where(role_id: 4)
  end

  def show
    @overtime_requests = @deputy_director.overtime_requests
  end

  private

  def set_deputy_director
    @deputy_director = User.find(params[:id])
  end
end

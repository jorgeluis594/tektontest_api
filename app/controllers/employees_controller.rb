class EmployeesController < ApplicationController

  rescue_from ActiveRecord::RecordInvalid do |e|
    send_error(e.message, :unprocessable_entity)
  end

  def index
    @employees = Employee.where(activated: true)
    send_success(@employees)
  end

  def show
    @employee = Employee.find(params[:id])
    send_success(@employee)
  end

  def create
    @employee = Employee.create!(get_params)
    send_success(@employee, :created)
  end

  private

  def get_params
    params.require(:employee).permit(:name, :dni, :email, :birth_date, :position, :manager_id)
  end
end

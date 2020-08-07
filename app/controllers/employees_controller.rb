class EmployeesController < ApplicationController
  def index
    @employees = Employee.where(activated: true)
    send_success(@employees)
  end

  def show
    @employee = Employee.find(params[:id])
    send_success({
                     id: @employee.id,
                     name: @employee.name,
                     email: @employee.email,
                     birth_date: @employee.birth_date,
                     position: @employee.position,
                     manager: @employee.manager,
                     subordinates: @employee.subordinates.where("activated = true")
                 })
  end

  def create
    @employee = Employee.create!(get_params)
    send_success(@employee, :created)
  end

  def destroy
    Employee.delete(params[:id])
    send_success("The employee was deleted");
  end

  def update
    @employee = Employee.find(params[:id])
    @employee.update!(get_params)
    send_success(@employee);
  end

  private

  def get_params
    params.require(:employee).permit(:name, :dni, :email, :birth_date, :position, :manager_id)
  end
end

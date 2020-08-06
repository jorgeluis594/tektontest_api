class ExpensesController < ApplicationController
  rescue_from ArgumentError do |e|
    send_error(e.message, :unprocessable_entity)
  end
  def index
    @expenses = Expense.all
    send_success(@expenses)
  end
  def show
    @expense = Expense.find(params['id'])
    send_success(@expense)
  end
  def create
    @expense = Expense.create!(get_params)
    send_success(@expense, :created)
  end

  private

  def get_params
    params.require(:expense).permit(:release_date, :category, :cost, :currency_type, :description)
  end
end

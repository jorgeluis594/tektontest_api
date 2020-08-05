class AddReferenceEmployeesToExpenses < ActiveRecord::Migration[6.0]
  def change
    add_reference :expenses, :employee, foreign_key: true
  end
end

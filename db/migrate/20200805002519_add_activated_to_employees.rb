class AddActivatedToEmployees < ActiveRecord::Migration[6.0]
  def change
    add_column :employees, :activated, :boolean
  end
end

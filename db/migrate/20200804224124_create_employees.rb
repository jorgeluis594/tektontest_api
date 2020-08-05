class CreateEmployees < ActiveRecord::Migration[6.0]
  def change
    create_table :employees do |t|
      t.string :name
      t.string :dni
      t.string :email
      t.date :birth_date
      t.integer :position
      t.references :manager

      t.timestamps
    end
  end
end

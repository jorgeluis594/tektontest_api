class CreateExpenses < ActiveRecord::Migration[6.0]
  def change
    create_table :expenses do |t|
      t.date :release_date
      t.integer :category
      t.decimal :cost
      t.integer :currency_type
      t.text :description

      t.timestamps
    end
  end
end

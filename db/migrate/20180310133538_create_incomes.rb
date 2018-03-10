class CreateIncomes < ActiveRecord::Migration[5.1]
  def change
    create_table :incomes do |t|
      t.string :name
      t.integer :paydays_per_year
      t.decimal :amount_per_payday

      t.timestamps
    end
  end
end

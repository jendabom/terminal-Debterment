class CreateDebts < ActiveRecord::Migration[5.1]
  def change
    create_table :debts do |t|
      t.string :name
      t.decimal :total_balance
      t.decimal :apr
      t.decimal :min_amt_due
      t.date :due_date
      t.string :type

      t.timestamps
    end
  end
end

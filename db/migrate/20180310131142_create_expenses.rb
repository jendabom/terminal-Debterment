class CreateExpenses < ActiveRecord::Migration[5.1]
  def change
    create_table :expenses do |t|
      t.string :name
      t.decimal :monthly_payment
      t.date :due_date
      t.string :type

      t.timestamps
    end
  end
end

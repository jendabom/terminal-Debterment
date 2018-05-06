class ChangeDueDateToInteger < ActiveRecord::Migration[5.1]
  def change
    remove_column :debts, :due_date, :date
    add_column :debts, :due_date, :integer
  end
end

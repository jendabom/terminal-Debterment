class AddPriorityToDebts < ActiveRecord::Migration[5.1]
  def change
    add_column :debts, :priority, :integer
  end
end

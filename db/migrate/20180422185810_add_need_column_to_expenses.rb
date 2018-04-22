class AddNeedColumnToExpenses < ActiveRecord::Migration[5.1]
  def change
    add_column :expenses, :need, :boolean
  end
end

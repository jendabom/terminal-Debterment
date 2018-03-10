class FixColumnName < ActiveRecord::Migration[5.1]
  def change
    rename_column :debts, :type, :debt_type
    rename_column :expenses, :type, :expense_type
  end
end

class AddUserIdToTables < ActiveRecord::Migration[5.1]
  def change
    add_column :debts, :user_id, :integer
    add_column :expenses, :user_id, :integer
    add_column :incomes, :user_id, :integer
  end
end

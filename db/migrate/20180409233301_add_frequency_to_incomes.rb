class AddFrequencyToIncomes < ActiveRecord::Migration[5.1]
  def change
    add_column :incomes, :recurring, :boolean 
  end
end

class AddStartDateToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :startDate, :date
  end
end

class AddPayoffPlanToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :preferred_payoff_method, :string
  end
end

class AddCreditCardLimitToDebt < ActiveRecord::Migration[5.1]
  def change
    add_column :debts, :card_limit, :decimal, precision: 8, scale: 2
  end
end

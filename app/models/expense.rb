class Expense < ApplicationRecord
  def as_json
  {
    name: name, 
    monthly_payment: monthly_payment, 
    expense_type: expense_type
  }
  end
end

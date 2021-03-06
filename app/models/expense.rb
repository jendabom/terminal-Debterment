class Expense < ApplicationRecord
  belongs_to :user
  def as_json
    {
      name: name, 
      monthly_payment: monthly_payment, 
      expense_type: expense_type, 
      need?: need
    }
  end
end

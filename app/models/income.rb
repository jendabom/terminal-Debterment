class Income < ApplicationRecord
  def as_json
    {
      name: name,
      monthly_income: monthly_income, 
      needs_goal: needs_amount,
      wants_goal: wants_amount,
      save_goal: save_amount
    }
  end

  def monthly_income
    (paydays_per_year * amount_per_payday) / 12
  end

  def needs_amount
    monthly_income * 0.5
  end

  def wants_amount
    monthly_income * 0.3
  end

  def save_amount
    monthly_income * 0.2
  end
end

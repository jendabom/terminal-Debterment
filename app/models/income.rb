class Income < ApplicationRecord
  def as_json
    {
      name: name,
      monthly_income: monthly_income, 
      needs_goal: needs_amount,
      wants_goal: wants_amount,
      save_goal: save_amount,
      complete_payoff_total: complete_payoff_total,
      saving_amount_only_months_til_paid: months_til_paid_off.to_i
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

  def complete_payoff_total
    Debt.sum(:total_balance)
  end

  def months_til_paid_off
    complete_payoff_total / save_amount
  end

end

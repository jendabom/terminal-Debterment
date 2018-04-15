class Income < ApplicationRecord
  belongs_to :user
  def as_json
    {
      name: name,
      monthly_income: monthly_income, 
      needs_goal: needs_amount,
      wants_goal: wants_amount,
      save_goal: save_amount,
      complete_payoff_total: complete_payoff_total,
      saving_amount_only_months_til_paid: months_til_paid_off.to_i, 
      min_all_paying_off: min_all_paying_off, 
      additional_amount: additional_amount, 
      mins_only_monthly_amount: mins_only_monthly_amount
    }
  end

  def current_user
    User.first
  end

  def monthly_income
    (paydays_per_year * amount_per_payday) / 12
  end

  def needs_amount
    monthly_income * needs_percentage
  end

  def wants_amount
    monthly_income * wants_percentage
  end

  def save_amount
    monthly_income * save_percentage
  end

  def complete_payoff_total
    Debt.sum(:total_balance)
  end

  def needs_total
    Expense.sum(:monthly_payment)
  end

  def min_amt_CC
    Debt.sum(:min_amt_due)
  end

  def mins_only_monthly_amount
    needs_total + min_amt_CC
  end

  def months_til_paid_off
    complete_payoff_total / save_amount
  end

  def needs_percentage
    0.5
  end

  def wants_percentage
    0.3
  end

  def save_percentage
    0.2
  end

  def min_all_paying_off
    Debt.sum(:min_amt_due)
  end

  def additional_amount
    save_amount - min_all_paying_off
  end
end

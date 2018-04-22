class Income < ApplicationRecord
  belongs_to :user
  def as_json
    {
      name: name,
      monthly_income: monthly_income,
      total_recurring_income: total_recurring_income, 
      needs_goal_based_on_total: needs_amount,
      wants_goal_based_on_total: wants_amount,
      save_goal_based_on_total: save_amount,
      saving_amount_only_months_til_paid: months_til_paid_off.to_i, 
      min_all_paying_off: min_all_paying_off, 
      additional_amount: additional_amount, 
      mins_only_monthly_amount: mins_only_monthly_amount, 
      credit_card_debt_total: credit_card_debt_total,
      other_debt_total: other_debt_total,
      complete_payoff_total: complete_payoff_total
    }
  end

  def current_user
    User.first
  end

  def monthly_income
    (paydays_per_year * amount_per_payday) / 12
  end

  def total_recurring_income
    incomes = Income.where(recurring: true)
    sum = 0
    incomes.each do |income|
      sum += income.monthly_income
    end
    return sum
  end

  def needs_amount
    total_recurring_income * needs_percentage
  end

  def wants_amount
    total_recurring_income * wants_percentage
  end

  def save_amount
    total_recurring_income * save_percentage
  end

  def complete_payoff_total
    Debt.sum(:total_balance)
  end

  def credit_card_debt
    Debt.where(debt_type: "Credit Card")
  end

  def other_debt
    Debt.where.not(debt_type: "Credit Card")
  end

  def credit_card_debt_total
    credit_card_debt.sum(:total_balance)
  end

  def other_debt_total
    other_debt.sum(:total_balance)
  end

  def needs_total
    Expense.sum(:monthly_payment)
  end

  def min_amt_cc
    credit_card_debt.sum(:min_amt_due)
  end

  def mins_only_monthly_amount
    needs_total + min_amt_cc
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

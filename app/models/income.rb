class Income < ApplicationRecord
  belongs_to :user
  def as_json
    {
      name: name,
      monthly_income: monthly_income,
      total_recurring_income: total_recurring_income, 
      needs_goal_based_on_total: needs_amount,
      total_needs_expenses: total_needs_expenses,
      remaining_needs_dollars: remaining_needs_dollars,
      wants_goal_based_on_total: wants_amount,
      total_wants_expenses: total_wants_expenses,
      remaining_wants_dollars: remaining_wants_dollars, 
      save_goal_based_on_total: save_amount,
      months_til_min_only_payoff: months_til_min_only_payoff.to_i,
      Additional_amount_months_til_paid: months_til_paid_off.to_i, 
      min_all_paying_off: min_all_paying_off, 
      credit_card_debt_total: credit_card_debt_total,
      other_debt_total: other_debt_total,
      complete_payoff_total: complete_payoff_total,
      additional_amount: additional_amount 
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

  def min_amt_cc
    credit_card_debt.sum(:min_amt_due)
  end

  def min_amt_other
    other_debt.sum(:min_amt_due)
  end

  def total_needs_expenses
    expenses = Expense.where(need: true).sum(:monthly_payment)
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

  def months_til_paid_off
    complete_payoff_total / (min_all_paying_off + additional_amount)
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

  def total_wants_expenses
    expenses = Expense.where(need: false).sum(:monthly_payment)
    sum = expenses + min_all_paying_off
    return sum
  end

  def remaining_needs_dollars
    needs_amount - total_needs_expenses
  end

  def remaining_wants_dollars
    wants_amount - total_wants_expenses
  end

  def months_til_min_only_payoff
    complete_payoff_total / min_all_paying_off
  end

  def additional_amount
    remaining_wants_dollars + remaining_needs_dollars + save_amount
  end
end

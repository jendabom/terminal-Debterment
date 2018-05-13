class User < ApplicationRecord
  has_many :debts
  has_many :expenses
  has_many :incomes
  has_secure_password
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, uniqueness: true

  def as_json
    {
      total_recurring_income: total_recurring_income, 
      total_needs_expenses: total_needs_expenses,
      min_all_paying_off: min_all_paying_off,
      total_wants_expenses: total_wants_expenses,
      needs_goal_based_on_total: needs_amount,
      remaining_needs_dollars: remaining_needs_dollars,
      wants_goal_based_on_total: wants_amount,
      remaining_wants_dollars: remaining_wants_dollars, 
      save_goal_based_on_total: save_amount,
      months_til_min_only_payoff: months_til_min_only_payoff.to_i,
      Additional_amount_months_til_paid: months_til_paid_off.to_i, 
      credit_card_debt_total: credit_card_debt_total,
      other_debt_total: other_debt_total,
      complete_payoff_total: complete_payoff_total,
      additional_amount: additional_amount 
    }
  end

  def total_recurring_income
    incomes = Income.where(user_id: self.id, recurring: true)
    sum = 0
    incomes.each do |income|
      sum += income.monthly_income
    end
    return sum
  end

  def total_needs_expenses
    expenses = Expense.where(user_id: self.id, need: true)
    sum = 0
    expenses.each do |expense|
      sum += expense.monthly_payment
    end
    return sum
  end

  def min_all_paying_off
    min_payments = Debt.where(user_id: self.id)
    sum = 0
    min_payments.each do |min_pay|
      sum += min_pay.min_amt_due
    end
    return sum
  end

  def total_wants_expenses
    expenses = Expense.where(user_id: self.id, need: false)
    sum = 0
    expenses.each do |expense|
      sum += expense.monthly_payment
    end
    sum = sum + min_all_paying_off
    return sum
  end

  def complete_payoff_total
    debts = Debt.where(user_id: self.id)
    sum = 0
    debts.each do |debt|
      sum += debt.total_balance
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

  def credit_card_debt
    debts = Debt.where(user_id: self.id, debt_type: "Credit Card")
  end

  def other_debt
    Debt.where(user_id: self.id).where.not(debt_type: "Credit Card")
  end

  def credit_card_debt_total
    credit_card_debt.sum(:total_balance)
  end

  def other_debt_total
    other_debt.sum(:total_balance)
  end

  def min_amt_cc
    credit_card_debt.sum(:min_amt_due)
  end

  def min_amt_other
    other_debt.sum(:min_amt_due)
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

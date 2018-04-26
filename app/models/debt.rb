class Debt < ApplicationRecord
  belongs_to :user
  def as_json
    {
      name: name,
      total_balance: total_balance,
      first_target: first_target,
      reach_first_target: payoff_amount, 
      apr: display_apr,
      min_amt_due: min_amt_due,
      #min_payment_payoff_months: months_til_min_only_payoff.to_i,
      due_date: due_date,
      debt_type: debt_type,
      limit: card_limit
    }
  end

  def target
    card_limit * 0.29
  end

  def first_target
    if debt_type == "Credit Card"
      return target
    else
      first_target = total_balance
    end
  end

  def payoff_amount
    if debt_type == "Credit Card"
      if total_balance - first_target <= 0
        return "Reached. Pay minimum until all have reached first target."
      else 
        return total_balance - first_target
      end
    else 
      return "Minimum payments until Credit Cards paid off."
    end
  end

  def months_til_min_only_payoff
    total_balance / min_amt_due
  end

  def display_apr
    (apr * 100).to_s + "%"
  end

  def snowball_debt_order
    debts = Debt.order(:total_balance).where(debt_type: "Credit Card")
    debts.each do |debt|
      Income.save_amount = Income.save_amount - debt.min_amt_due
    end
  end
end

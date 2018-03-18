class Debt < ApplicationRecord
  def as_json
    {
      name: name,
      total_balance: total_balance,
      first_target: first_target,
      reach_first_target: payoff_amount, 
      # apr: apr,
      min_amt_due: min_amt_due,
      min_payment_payoff_months: months_til_paid_off.to_i,
      # due_date: due_date,
      debt_type: debt_type, 
      # limit: card_limit
    }
  end

  def target
    card_limit * 0.30
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
        return "First target reached."
      else 
        return total_balance - first_target
      end
    else 
      return "Minimim payments until Credit Cards paid off."
    end
  end

  def months_til_paid_off
    total_balance / min_amt_due
  end

end

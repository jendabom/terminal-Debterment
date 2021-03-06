class Debt < ApplicationRecord
  belongs_to :user
  def as_json
    {
      id: id,
      name: name,
      total_balance: total_balance,
      first_target: first_target,
      reach_first_target: payoff_amount, 
      apr: display_apr,
      min_amt_due: min_amt_due,
      #min_payment_payoff_months: months_til_min_only_payoff.to_i,
      due_date: due_date,
      pretty_due_date: due_date.ordinalize,
      debt_type: debt_type,
      limit: card_limit, 
      priority: priority,
      pretty_priority: priority_ordinalize
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

  def priority_ordinalize
    if total_balance != 0
      priority.ordinalize
    else
      priority
    end
  end
end

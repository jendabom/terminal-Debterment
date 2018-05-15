class DebtsController < ApplicationController
  require 'date'
  wrap_parameters format: [:json]

  def index
    debts = Debt.where(user_id: current_user.id)
    render json: debts.as_json
  end

  def create
    debt = Debt.new(
      name: params[:name],
      total_balance: params[:total_balance],
      apr: params[:apr],
      min_amt_due: params[:min_amt_due], 
      due_date: params[:due_date],
      debt_type: params[:debt_type], 
      card_limit: params[:card_limit], 
      user_id: current_user.id
    )
    if debt.save
      render json: debt.as_json
    else
      render json: {errors: debt.errors.full_messages}, status: :unprocessible_entity
    end
  end

  def show
    debt = Debt.find(params[:id])
    render json: debt.as_json
  end

  def destroy
    debt = Debt.find(params[:id])
    debt.destroy
    render json: {message: "I did the thing and deleted that debt."}
  end

  def update
    debt = Debt.find(params[:id])
    debt.update(
      name: params[:name],
      total_balance: params[:total_balance],
      apr: params[:apr],
      min_amt_due: params[:min_amt_due], 
      due_date: params[:due_date],
      debt_type: params[:debt_type], 
      card_limit: params[:card_limit],
      priority: params[:priority] )
  end

  def payoff_update
    params_body = params["_json"]
    params_body.each do |param|
      debt = Debt.find(param[:id])
      debt.update(total_balance: param[:total_balance])
    end
  end

  def snowball
    debts = Debt.order(:total_balance).where(
      user_id: current_user.id, 
      debt_type: "Credit Card"
    )
    render json: debts.as_json
  end

  def avalanche
    debts = Debt.order(apr: :desc).where(
      user_id: current_user.id, 
      debt_type: "Credit Card"
    )
    render json: debts.as_json
  end

  def sorted_debts
    payoff_debts = Debt.where.not(total_balance: 0)

    if current_user.preferred_payoff_method == "snowball"
      credit_card_debts = payoff_debts.order(:total_balance).where( 
        user_id: current_user.id,
        debt_type: "Credit Card"
      )
    elsif current_user.preferred_payoff_method == "avalanche"
      credit_card_debts = payoff_debts.order(apr: :desc).where( 
        user_id: current_user.id,
        debt_type: "Credit Card"
      )
    end

    non_credit_card_debts = payoff_debts.where.not(
        debt_type: "Credit Card"
      )
    all_debts = credit_card_debts + non_credit_card_debts.where(user_id: current_user.id)
    set_priority(all_debts)
    render json: all_debts.as_json
  end

  def monthly_due_date_order
    payoff_debts = Debt.where.not(total_balance: 0)
    debts = payoff_debts.order(:due_date).where(
      user_id: current_user.id
    )
    render json: debts.as_json
  end

  def set_priority(debts)
    i = 1
    debts.each do |debt|
      if debt.total_balance != 0
        debt.update_attribute(:priority, i)
        i += 1
      end
    end
  end

  def complete_payoff_total
    debts = Debt.where(user_id: 1)
    sum = 0
    debts.each do |debt|
      sum += debt.total_balance
    end
    return sum
  end

  def min_all_paying_off
    debts = Debt.where(user_id: 1)
    sum = 0
    debts.each do |debt|
      sum += debt.min_amt_due
    end
    return sum
  end

  def dates_for_payoff_chart
    current_user = User.first
    dates = []
    start_date = current_user.startDate
    dates << {date: start_date, total_balance: complete_payoff_total, additional_paydown: complete_payoff_total}

    new_complete_payoff_total_with_min = complete_payoff_total - min_all_paying_off
    new_complete_payoff_total_with_additional = complete_payoff_total - (min_all_paying_off + 500)

    current_month = start_date
      while new_complete_payoff_total_with_min > 0 do
      complete_payoff_total = new_complete_payoff_total_with_min

      next_month = current_month >> 1
      p next_month
      dates << {date: next_month, total_balance: (complete_payoff_total), additional_paydown: new_complete_payoff_total_with_additional}
      new_complete_payoff_total_with_min = complete_payoff_total - min_all_paying_off
      if new_complete_payoff_total_with_additional > (min_all_paying_off + 500)
        new_complete_payoff_total_with_additional = new_complete_payoff_total_with_additional - (min_all_paying_off + 500)
      else
        new_complete_payoff_total_with_additional = 0
      end
      current_month = next_month
    end
    render json: dates.as_json
  end
end

class DebtsController < ApplicationController
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

    non_credit_card_debts = payoff_debts.where(
        user_id: current_user.id
      ) && payoff_debts.where.not(
        debt_type: "Credit Card"
      )
    all_debts = credit_card_debts + non_credit_card_debts
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
      debt.update_attribute(:priority, i)
      i += 1
    end
  end
end

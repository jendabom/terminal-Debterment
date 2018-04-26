class DebtsController < ApplicationController
  def index
    debts = Debt.all
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

  def snowball
    debts = Debt.order(:total_balance).where(user_id: current_user.id, debt_type: "Credit Card")
    render json: debts.as_json
  end

  def avalanche
    debts = Debt.order(apr: :desc).where(user_id: current_user.id, debt_type: "Credit Card")
    render json: debts.as_json
  end

  def sorted_debts
    credit_card_debts = Debt.order(apr: :desc).where(user_id: current_user.id, debt_type: "Credit Card")
    non_credit_card_debts = Debt.where(user_id: current_user.id) && Debt.where.not(debt_type: "Credit Card")
    all_debts = credit_card_debts + non_credit_card_debts
    render json: all_debts.as_json
  end
end

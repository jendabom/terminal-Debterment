class DebtsController < ApplicationController
  def index
    debts = Debt.all.order(:total_balance)
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
      user_id: User.first.id
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
end

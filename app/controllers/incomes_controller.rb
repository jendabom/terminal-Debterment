class IncomesController < ApplicationController
  def index
    incomes = Income.where(user_id: current_user.id)
    render json: incomes.as_json
  end

  def show_all
    all_data = {
      incomes: Income.where(user_id: current_user.id),
      expenses: Expense.where(user_id: current_user.id),
      debts: Debt.where(user_id: current_user.id)
    }
    render json: all_data.as_json
  end

  def create
    income = Income.new(
      name: params[:name],
      paydays_per_year: params[:paydays_per_year],
      amount_per_payday: params[:amount_per_payday],
      user_id: current_user.id, 
      recurring: params[:recurring]
    )
    if income.save
      render json: income.as_json
    else
      render json: {errors: income.errors.full_messages}, status: :unprocessible_entity
    end
  end
  
  def show
    income = Income.find(params[:id])
    render json: income.as_json
  end
end

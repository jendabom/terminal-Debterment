class IncomesController < ApplicationController
  def index
    incomes = Income.all
    render json: incomes.as_json
  end

  def show_all
    all_data = {
      incomes: Income.all,
      expenses: Expense.all,
      debts: Debt.all
    }
    render json: all_data.as_json
  end

  def create
    income = Income.new(
      name: params[:name],
      paydays_per_year: params[:paydays_per_year],
      amount_per_payday: params[:amount_per_payday],
      user_id: current_user.id
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

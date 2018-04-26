class ExpensesController < ApplicationController
  def index
    expenses = Expense.all
    render json: expenses.as_json
  end

  def create
    expense = Expense.new(
      name: params[:name],
      monthly_payment: params[:monthly_payment],
      expense_type: params[:expense_type],
      user_id: current_user.id
    )
    if expense.save
      render json: expense.as_json
    else
      render json: {errors: expense.errors.full_messages}, status: :unprocessible_entity
    end
  end

  def show
    expense = Expense.find(params[:id])
    render json: expense.as_json
  end

  def destroy
    expense = Expense.find(params[:id])
    expense.destroy
    render json: {message: "I did the thing and deleted that expense."}
  end
end

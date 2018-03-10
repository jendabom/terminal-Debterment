class ExpensesController < ApplicationController
  def index
    expenses = Expense.all
    render json: expenses.as_json
  end
end

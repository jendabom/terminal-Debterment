class DebtsController < ApplicationController
  def index
    debts = Debt.all.order(:total_balance)
    render json: debts.as_json
  end
end

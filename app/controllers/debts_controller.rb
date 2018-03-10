class DebtsController < ApplicationController
  def index
    debts = Debt.all
    render json: debts.as_json
  end
end

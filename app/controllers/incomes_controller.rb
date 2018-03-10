class IncomesController < ApplicationController
  def index
    incomes = Income.all
    render json: incomes.as_json
  end
end

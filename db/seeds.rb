  # create_table "debts", force: :cascade do |t|
  #   t.string "name"
  #   t.decimal "total_balance"
  #   t.decimal "apr"
  #   t.decimal "min_amt_due"
  #   t.date "due_date"
  #   t.string "type"
  #   t.datetime "created_at", null: false
  #   t.datetime "updated_at", null: false
  # end

  # create_table "expenses", force: :cascade do |t|
  #   t.string "name"
  #   t.decimal "monthly_payment"
  #   t.date "due_date"
  #   t.string "type"
  #   t.datetime "created_at", null: false
  #   t.datetime "updated_at", null: false
  # end

  debt = Debt.new(name: "Bank of America", total_balance: 5000, min_amt_due: 50, apr: 0.20, due_date: "3/15/2018", debt_type: "Credit Card", card_limit: 8000)
  debt.save

  debt = Debt.new(name: "Chase", total_balance: 200, min_amt_due: 25, apr: 0.18, due_date: "3/22/2018", debt_type: "Credit Card", card_limit: 1500)
  debt.save

  debt = Debt.new(name: "Amex", total_balance: 650, min_amt_due: 25, apr: 0.18, due_date: "3/25/2018", debt_type: "Credit Card", card_limit: 1000)
  debt.save

  debt = Debt.new(name: "Citi Bank", total_balance: 400, min_amt_due: 25, apr: 0.18, due_date: "3/22/2018", debt_type: "Credit Card", card_limit: 1500)
  debt.save

  debt = Debt.new(name: "Upstart Loan", total_balance: 10000, min_amt_due: 405, apr: 0.18, due_date: "3/22/2018", debt_type: "Loan")
  debt.save

  expense = Expense.new(name: "Rent", monthly_payment: 1100, expense_type: "living expenses")
  expense.save

  expense = Expense.new(name: "Netflix", monthly_payment: 12.50, expense_type: "subscription")
  expense.save

  income = Income.new(name: "Betterment", paydays_per_year: 24, amount_per_payday: 1600)
  income.save

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

  debt = Debt.new(name: "Bank of America", total_balance: 5000, min_amt_due: 50, apr: 0.20, due_date: "3/15/2018", debt_type: "Credit Card")
  debt.save

  debt = Debt.new(name: "Chase", total_balance: 200, min_amt_due: 25, apr: 0.18, due_date: "3/22/2018", debt_type: "Credit Card")
  debt.save

  debt = Debt.new(name: "Upstart Loan", total_balance: 10000, min_amt_due: 405, apr: 0.18, due_date: "3/22/2018", debt_type: "Credit Card")
  debt.save

  expense = Expense.new(name: "Rent", monthly_payment: 1100, expense_type: "living expenses")
  expense.save

  expense = Expense.new(name: "Netflix", monthly_payment: 12.50, expense_type: "subscription")
  expense.save

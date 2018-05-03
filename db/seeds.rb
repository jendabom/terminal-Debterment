User.create!([
  {first_name: "Jamie", last_name: "MacKillop", email: "jamie@jamie.com", password_digest: "$2a$10$5EAqRxulyjZazwp3BKhpduTV33O5qFNd1hyDpZq6tcxKnrOj3Kxj6", preferred_payoff_method: "avalanche"},
  {first_name: "Jennifer", last_name: "Blom", email: "jen.blom@gmail.com", password_digest: "$2a$10$W.IgRVqzJ.rtQgrwjEEPc.izS6ZvNjFrYcMykLybT.jr6lgDupH3y", preferred_payoff_method: "avalanche"}
])
Debt.create!([
  {name: "Upstart Loan", total_balance: "10000.0", apr: "0.18", min_amt_due: "405.0", due_date: "2018-04-25", debt_type: "Loan", card_limit: nil, user_id: 1},
  {name: "Amex", total_balance: "650.0", apr: "0.17", min_amt_due: "25.0", due_date: "2018-05-13", debt_type: "Credit Card", card_limit: "1000.0", user_id: 1},
  {name: "Chase", total_balance: "200.0", apr: "0.12", min_amt_due: "25.0", due_date: "2018-05-22", debt_type: "Credit Card", card_limit: "1500.0", user_id: 1},
  {name: "American Express", total_balance: "7500.0", apr: "0.15", min_amt_due: "45.0", due_date: "2018-04-07", debt_type: "Credit Card", card_limit: "10000.0", user_id: 1},
  {name: "Amazon Credit Card", total_balance: "5325.0", apr: "0.17", min_amt_due: "25.0", due_date: "2018-05-27", debt_type: "Credit Card", card_limit: "10000.0", user_id: 1},
  {name: " Sears", total_balance: "2733.0", apr: "0.15", min_amt_due: "45.0", due_date: "2018-05-16", debt_type: "Credit Card", card_limit: "5000.0", user_id: 1},
  {name: "JC Penny", total_balance: "102.0", apr: "0.09", min_amt_due: "10.0", due_date: "2018-05-07", debt_type: "Credit Card", card_limit: "500.0", user_id: 1},
  {name: "My Fed Loan", total_balance: "33000.0", apr: "0.075", min_amt_due: "175.0", due_date: "2018-05-25", debt_type: "Student Loan", card_limit: "0.0", user_id: 1},
  {name: "American Express", total_balance: "2550.0", apr: "0.17", min_amt_due: "25.0", due_date: "2018-05-23", debt_type: "Credit Card", card_limit: "5000.0", user_id: 2},
  {name: "Bank of America Car Loan", total_balance: "22024.0", apr: "0.09", min_amt_due: "275.0", due_date: "2018-05-12", debt_type: "Car Loan", card_limit: "0.0", user_id: 2},
  {name: "Citi Bank", total_balance: "400.0", apr: "0.16", min_amt_due: "25.0", due_date: "2018-04-18", debt_type: "Credit Card", card_limit: "1500.0", user_id: 2},
  {name: "Bank of America", total_balance: "0.0", apr: "0.2", min_amt_due: "50.0", due_date: "2018-05-08", debt_type: "Credit Card", card_limit: "8000.0", user_id: 1},
  {name: "Target Store Card", total_balance: "557.0", apr: "0.22", min_amt_due: "20.0", due_date: "2018-05-23", debt_type: "Credit Card", card_limit: "1000.0", user_id: 1},
  {name: "", total_balance: "0.0", apr: "0.0", min_amt_due: nil, due_date: nil, debt_type: "", card_limit: "0.0", user_id: 1}
])
Expense.create!([
  {name: "RCN", monthly_payment: "55.0", due_date: "2018-05-01", expense_type: "Internet", user_id: 1, need: false},
  {name: "Rent", monthly_payment: "1100.0", due_date: "2018-05-01", expense_type: "living expenses", user_id: 1, need: true},
  {name: "Progressive", monthly_payment: "125.0", due_date: "2018-05-13", expense_type: "Insurance", user_id: 1, need: true},
  {name: "Rent", monthly_payment: "1750.0", due_date: "2018-05-01", expense_type: "living expenses", user_id: 2, need: true},
  {name: "Netflix", monthly_payment: "12.5", due_date: "2018-05-13", expense_type: "subscription", user_id: 2, need: false}
])
Income.create!([
  {name: "My Joerb", paydays_per_year: 24, amount_per_payday: "1600.0", user_id: 1, recurring: true},
  {name: "Freelance", paydays_per_year: 12, amount_per_payday: "200.0", user_id: 1, recurring: true},
  {name: "Tax return", paydays_per_year: 1, amount_per_payday: "50.0", user_id: 1, recurring: false},
  {name: "Bonus", paydays_per_year: 1, amount_per_payday: "1000.0", user_id: 1, recurring: false},
  {name: "WerkIt", paydays_per_year: 24, amount_per_payday: "1875.0", user_id: 2, recurring: true},
  {name: "Disney", paydays_per_year: 24, amount_per_payday: "4200.0", user_id: 2, recurring: true},
  {name: "Etsy", paydays_per_year: 12, amount_per_payday: "50.0", user_id: 1, recurring: true},
  {name: "Ebay", paydays_per_year: 12, amount_per_payday: "50.0", user_id: 1, recurring: true}
])


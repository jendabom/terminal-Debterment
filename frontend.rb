require 'unirest'

# base_url = "localhost:3000"

debts_response = Unirest.get('localhost:3000/debts')
debts = debts_response.body

debts.each do |debt|
  p "Debtor: #{debt['name']}"
  p "Total Balance: #{debt['total_balance']}"
  p "Monthly Amount Due: #{debt['min_amt_due']}"
  p "Debt Type: #{debt['debt_type']}"
  p "-" * 30  
end

expenses_response = Unirest.get('localhost:3000/expenses')
expenses = expenses_response.body

p "-" * 30  
expenses.each do |expense|
  p "Expense: #{expense['name']}"
  p "Monthly Amount Due: #{expense['monthly_payment']}"
  p "Expense Type: #{expense['expense_type']}"
  p "-" * 30  
end
require 'unirest'

base_url = "localhost:3000"
while true
  p "What would you like to do?"
  p "[1] View all Debts"
  p "[2] View all Expenses"
  p "[3] Add a Debt"
  p "[4] View Income"
  p "[5] Add an Expense"
  p "[6] Add an Income"
  p "[7] Delete a Debt"
  p "[8] Show a single Debt"
  p "[9] Show a single Expense"
  p "[10] Show a single Incomes"
  p "[11] Delete an Expense"
  p "[12] Login"
  p "[13] Logout"

  user_input = gets.chomp

  if user_input == "1"
    system "clear"
    debts_response = Unirest.get("#{base_url}/debts")
    debts = debts_response.body
    p "-" * 30
    p "Debts"
    p "-" * 30  
    puts JSON.pretty_generate(debts)
  elsif user_input == "2"
    system "clear"
    expenses_response = Unirest.get("#{base_url}/expenses")
    expenses = expenses_response.body

    p "-" * 30
    p "Expenses"
    p "-" * 30  
    puts JSON.pretty_generate(expenses)
  elsif user_input == "3"
    client_params = {}
    p "Name:"
    client_params[:name] = gets.chomp
    p "Total Balance:"
    client_params[:total_balance] = gets.chomp
    p "What is the apr in decimal form"
    client_params[:apr] = gets.chomp
    p "What is the minimum amount due each month:"
    client_params[:min_amt_due] = gets.chomp
    p "What is the debt type:"
    client_params[:debt_type] = gets.chomp 

    response = Unirest.post(
                          "http://localhost:3000/debts",
                          parameters: client_params
                          )
    debt_data = response.body
    p debt_data
  elsif user_input == "4"
    system "clear"
    incomes_response = Unirest.get("#{base_url}/incomes")
    incomes = incomes_response.body
    p "-" * 30
    p "Incomes"
    p "-" * 30  
    puts JSON.pretty_generate(incomes)
  elsif user_input == "5"
    client_params = {}
    p "Name:"
    client_params[:name] = gets.chomp
    p "Monthly Amount:"
    client_params[:monthly_payment] = gets.chomp
    p "Expense Type"
    client_params[:expense_type] = gets.chomp
    response = Unirest.post(
                          "http://localhost:3000/expenses",
                          parameters: client_params
                          )
    expense_data = response.body
    p expense_data
  elsif user_input == "6"
    client_params = {}
    p "Name:"
    client_params[:name] = gets.chomp
    p "Paydays Per year:"
    client_params[:paydays_per_year] = gets.chomp
    p "Amount Per Payday:"
    client_params[:amount_per_payday] = gets.chomp
    response = Unirest.post(
                          "http://localhost:3000/incomes",
                          parameters: client_params
                          )
    income_data = response.body
    p income_data
  elsif user_input == "7"
    print "Enter debt id: "
    input_id = gets.chomp

    response = Unirest.delete("http://localhost:3000/debts/#{input_id}")
    p response
    data = response.body
    puts data["message"]
  elsif user_input == "8"
    print "Enter debt id: "
    input_id = gets.chomp

    response = Unirest.get("http://localhost:3000/debts/#{input_id}")
    debt = response.body
    puts JSON.pretty_generate(debt)
  elsif user_input == "9"
    print "Enter expense id: "
    input_id = gets.chomp

    response = Unirest.get("http://localhost:3000/expenses/#{input_id}")
    expense = response.body
    puts JSON.pretty_generate(expense)
  elsif user_input == "10"
    print "Enter income id: "
    input_id = gets.chomp

    response = Unirest.get("http://localhost:3000/incomes/#{input_id}")
    income = response.body
    puts JSON.pretty_generate(income)
  elsif user_input == "11"
    print "Enter expense id: "
    input_id = gets.chomp

    response = Unirest.delete("http://localhost:3000/expenses/#{input_id}")
    p response
    data = response.body
    puts data["message"]
  elsif user_input == "12"
    response = Unirest.post(
      "http://localhost:3000/user_token",
      parameters: {
        auth: {
          email: "jen.blom@gmail.com",
          password: "password"
        }
      }
    )

    # Save the JSON web token from the response
    jwt = response.body["jwt"]
    # Include the jwt in the headers of any future web requests
    Unirest.default_header("Authorization", "Bearer #{jwt}")
    user = response.body
    p user
  elsif user_input == "13"
    jwt = ""
    Unirest.clear_default_headers()
    p jwt
  end
end
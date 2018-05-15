Rails.application.routes.draw do
  post 'user_token' => 'user_token#create'
  get '/debts' => 'debts#index'
  post '/debts' => 'debts#create'
  get '/debts/:id' => 'debts#show'
  delete 'debts/:id' => 'debts#destroy'
  patch 'debts/all' => 'debts#payoff_update'
  patch 'debts/:id' => 'debts#update'
  
  get '/snowball' => 'debts#snowball'
  get '/avalanche' => 'debts#avalanche'
  get '/alldebts' => 'debts#sorted_debts'
  get '/monthly_payoff' => 'debts#monthly_due_date_order'
  get '/chart_info' => 'debts#dates_for_payoff_chart'

  get '/expenses' => 'expenses#index'
  post '/expenses' => 'expenses#create'
  get '/expenses/:id' => 'expenses#show'
  delete 'expenses/:id' => 'expenses#destroy'

  get '/incomes' => 'incomes#index'
  post '/incomes' => 'incomes#create'
  get '/incomes/:id' => 'incomes#show'

  get '/showall' => 'incomes#show_all'

  post "/users" => "users#create"
end

Rails.application.routes.draw do
  post 'user_token' => 'user_token#create'
  get '/debts' => 'debts#index'
  post '/debts' => 'debts#create'
  get '/debts/:id' => 'debts#show'
  delete 'debts/:id' => 'debts#destroy'

  get '/expenses' => 'expenses#index'
  post '/expenses' => 'expenses#create'
  get '/expenses/:id' => 'expenses#show'
  delete 'expenses/:id' => 'expenses#destroy'

  get '/incomes' => 'incomes#index'
  post '/incomes' => 'incomes#create'
  get '/incomes/:id' => 'incomes#show'

  post "/users" => "users#create"
end

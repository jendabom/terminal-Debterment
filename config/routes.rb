Rails.application.routes.draw do
  post 'user_token' => 'user_token#create'
  get '/debts' => 'debts#index'
  get '/expenses' => 'expenses#index'
  get '/incomes' => 'incomes#index'

  post "/users" => "users#create"
end

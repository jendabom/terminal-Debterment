Rails.application.routes.draw do
  get '/debts' => 'debts#index'






  get '/expenses' => 'expenses#index'
end

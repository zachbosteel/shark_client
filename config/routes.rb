Rails.application.routes.draw do
  get "/" => 'sharks#index'
  get "/sharks" => 'sharks#index'  
  get "/sharks/new" => 'sharks#new'
  post "/sharks" => 'sharks#create'
  get "/sharks/:id" => 'sharks#show'
  delete "/sharks/:id" => 'sharks#destroy'
  get "sharks/:id/edit" => 'sharks#edit'
end

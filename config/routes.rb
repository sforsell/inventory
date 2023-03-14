Rails.application.routes.draw do
  constraints subdomain: /.*/ do
    get 'recipes', to: 'inventory#recipes'
    get 'inventory/delivery', to: 'inventory#show_inventory'
  end

  root 'inventory#index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
end

Rails.application.routes.draw do
  resources :ms_column_types
  resources :tables
  resources :table_types
  resources :projects
  root to: 'visitors#index'
end

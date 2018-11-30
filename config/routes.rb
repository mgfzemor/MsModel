Rails.application.routes.draw do
  resources :foreign_keys
  resources :primary_keys
  resources :rails_types
  resources :columns
  resources :ms_column_types
  resources :tables
  resources :table_types
  resources :projects
  root to: 'visitors#index'
end

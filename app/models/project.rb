class Project < ApplicationRecord
  has_many :tables, foreign_key: "projects_id", class_name: "Table"
end

class PrimaryKey < ApplicationRecord
  belongs_to :table
  belongs_to :column
end

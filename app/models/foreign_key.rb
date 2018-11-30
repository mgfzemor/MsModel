class ForeignKey < ApplicationRecord
  belongs_to :table, foreign_key: 'source_table'
  belongs_to :table, foreign_key: 'target_table'
  belongs_to :column, foreign_key: 'source_column'
  belongs_to :column, foreign_key: 'target_column'
end

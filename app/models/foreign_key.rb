class ForeignKey < ApplicationRecord
  belongs_to :table, foreign_key: 'source_table'
  belongs_to :table, foreign_key: 'target_table'
  belongs_to :column, foreign_key: 'source_column'
  belongs_to :column, foreign_key: 'target_column'

  def source_td
    Table.find(source_table)
  end

  def source_cd
    Column.find(source_column)
  end

  def target_td
    Table.find(target_table)
  end

  def target_cd
    Column.find(target_column)
  end
end

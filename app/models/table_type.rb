class TableType < ApplicationRecord
  def option
    self.prefix + '  |  ' + self.name
  end
end

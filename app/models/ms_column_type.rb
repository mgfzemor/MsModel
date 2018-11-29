class MsColumnType < ApplicationRecord
  def options_for_select
    self.prefix + '  |  ' + self.name
  end
end

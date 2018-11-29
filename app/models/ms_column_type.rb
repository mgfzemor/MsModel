class MsColumnType < ApplicationRecord
  def options_for_select
    self.prefix + '  |  ' + self.name
  end

  def type_name
    tp_name = RailsType.find(self.rails_types_id).name
  end

end

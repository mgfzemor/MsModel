class Table < ApplicationRecord
  def project_name
    Project.find(self.projects_id).title
  end

  def type
    TableType.find(self.table_types_id)
  end

  def ms_database_name
    prefix = self.type.prefix
    prefix + self.database_name
  end

end

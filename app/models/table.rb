class Table < ApplicationRecord
  has_many :columns, :foreign_key => "tables_id", :class_name => "Column"
  def project_name
    Project.find(self.projects_id).title
  end

  def type
    TableType.find(self.table_types_id)
  end

  def newline
    string = '<br/>'
  end

  def indent
    string = '&ensp;&ensp;'
  end

  def ms_database_name
    prefix = self.type.prefix
    prefix + self.database_name
  end

  def generate_table_name
    table_name =  "self.table_name = ':" + self.ms_database_name + "'" + newline
  end

  def generate_getter(attribute)
    header = 'def ' +  attribute.system_name + '(value)' + newline
    body =  indent + 'write_attribute(:' + attribute.ms_database_name + ', value)' + newline
    footer = 'end' + newline
    getter = header + body + footer + newline
  end

  def generate_setter(attribute)
    header = 'def ' +  attribute.system_name + newline
    body =  indent + 'read_attribute(:' + attribute.ms_database_name + ')' + newline
    footer = 'end' + newline
    setter = header + body + footer + newline
  end

  def generate_scaffold
    prefix = 'rails g scaffold ' + self.system_name + ' '
    scaffold = prefix
    self.columns.each do |c|
      scaffold.concat(c.system_name)
      scaffold.concat(':type ')
    end
    scaffold
  end

  def generate_getters_and_setters
    code = generate_table_name + newline
    self.columns.each  do |column|
      getter = generate_getter(column)
      setter = generate_setter(column)
      code.concat(getter)
      code.concat(setter)
    end
    code
  end

  def create_migration_up
    function = 'def up' + newline
    create_table = indent + 'create_table :' + self.ms_database_name + ' do |t|' + newline
    db_columns = ''
    self.columns.each do |c|
      db_columns.concat(indent+indent+ 't.type :' + c.ms_database_name + newline)
    end
    db_columns.concat(indent + 'end' + newline)
    migration_up = function + create_table + db_columns + 'end' + newline
  end

  def create_migration_down
    function = 'def down' + newline
    
  end

  def generate_migration
    create_migration_up
  end

end

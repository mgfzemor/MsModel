class Table < ApplicationRecord
  belongs_to :project, foreign_key: 'projects_id', class_name: 'Project'
  has_many :columns, foreign_key: 'tables_id', class_name: 'Column'
  has_many :foreign_keys, foreign_key: 'source_table'
  has_one :primary_key

  def project_name
    Project.find(projects_id).title
  end

  def type
    TableType.find(table_types_id)
  end

  def parsed_columns
    columns.map { |c| { id: c.id, name: c.ms_database_name } }
  end

  def column_type(column); end

  def newline
    '<br/>'
  end

  def indent
    '&ensp;&ensp;'
  end

  def ms_database_name
    type.prefix + database_name
  end

  def generate_table_name
    "self.table_name = ':" + ms_database_name + "'" + newline
  end

  def generate_getter(attribute)
    header = 'def ' +  attribute.system_name + '(value)' + newline
    body = indent + 'write_attribute(:' + attribute.ms_database_name + ', value)' + newline
    footer = 'end' + newline
    header + body + footer + newline
  end

  def generate_setter(attribute)
    header = 'def ' + attribute.system_name + newline
    body = indent + 'read_attribute(:' + attribute.ms_database_name + ')' + newline
    footer = 'end' + newline
    header + body + footer + newline
  end

  def set_null
    ', null: false '
  end

  def set_unique
    ', unique: true'
  end

  def generate_scaffold
    prefix = 'rails g scaffold ' + system_name + ' '
    scaffold = prefix
    columns.each do |c|
      scaffold.concat(c.system_name)
      scaffold.concat(':' + c.ms_column_types.type_name + ' ')
    end
    scaffold
  end

  def generate_getters_and_setters
    code = generate_table_name + newline
    columns.each do |column|
      code.concat(generate_getter(column))
      code.concat(generate_setter(column))
    end

    code
  end

  def set_constraints(column)
    constraints = ''
    constraints.concat(set_null) if column.nn # not null
    constraints.concat(set_unique) if column.uq # unique

    constraints
  end

  def set_id
    self.active_id ? '' : ', id: false'
  end

  def pk_name
    Column.find(self.primary_key.column_id).ms_database_name
  end

  def create_primary_key
    db = self.ms_database_name
    pk = ''
    pk.concat(indent + "execute #{'"'}ALTER TABLE '#{db}' ADD CONSTRAINT 'PK_#{db}' PRIMARY KEY ('#{pk_name}')#{'"'}" + newline) if self.primary_key
    pk
  end

  def drop_primary_key
    db = self.ms_database_name
    pk = ''
    pk.concat(indent + "execute #{'"'}ALTER TABLE '#{db}' DROP CONSTRAINT 'PK_#{db}'#{'"'}" + newline) if self.primary_key
    pk
  end

  def create_migration_up
    function = 'def up' + newline
    create_table = indent + 'create_table :' + self.ms_database_name + set_id + ' do |t|' + newline
    db_columns = ''
    columns.each do |c|
      db_columns.concat(indent + indent + 't.type :' + c.ms_database_name)
      constraints = set_constraints(c)
      db_columns.concat(constraints + newline)
    end
    db_columns.concat(indent + 'end' + newline)
    function + create_table + db_columns + create_primary_key + end_function
  end

  def end_function
    'end' + newline + newline
  end

  def create_migration_down
    function = 'def down' + newline
    drop_table = indent + 'drop_table :' + self.ms_database_name + newline
    function + drop_table + drop_primary_key + end_function
  end

  def generate_migration
    up = create_migration_up
    down = create_migration_down
    up + down
  end
end

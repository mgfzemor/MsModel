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

  def indent(qty = 1)
    inicial = ''
    qty.times { inicial += '&ensp;&ensp;' }
    inicial
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

  def pk_column_name
    Column.find(self.primary_key.column_id).ms_database_name
  end

  def str(string)
    "\"#{string}\""
  end

  def create_primary_key
    db = self.ms_database_name
    pk = ''
    if self.primary_key
      string = indent + "execute 'ALTER TABLE %s ADD CONSTRAINT %s PRIMARY KEY (%s);'" + newline
      pk = string % [str(db), str(db), str(pk_column_name)]
    end
    pk
  end

  def create_foreign_keys
    fk_text = ''
    ti = newline + indent(3)
    self.foreign_keys.each do |fk|
      string = "execute 'ALTER TABLE %s#{ti} \
ADD CONSTRAINT \"FK_%s_%s\" FOREIGN KEY (\"%s\")#{ti} \
REFERENCES %s (%s) MATCH SIMPLE#{ti} \
ON UPDATE RESTRICT#{ti} \
ON DELETE RESTRICT;#{newline + indent(2)} \
CREATE INDEX \"IN_FK_%s_%s\"#{ti} \
ON %s(\"%s\");'#{newline}"
      fk_text += indent + string % [self.ms_database_name,
                                    fk.target_td.database_name,
                                    self.database_name,
                                    fk.source_td.ms_database_name,
                                    fk.target_td.ms_database_name,
                                    fk.target_cd.ms_database_name,
                                    fk.target_td.database_name,
                                    self.database_name,
                                    self.ms_database_name,
                                    fk.source_cd.ms_database_name]
    end
    fk_text
  end

  def drop_primary_key
    pk = ''
<<<<<<< Updated upstream
    pk.concat(indent + "execute 'ALTER TABLE '#{db}' DROP CONSTRAINT 'PK_#{db}';'" + newline) if self.primary_key
=======
    if self.primary_key
      string = indent + "execute 'ALTER TABLE %s DROP CONSTRAINT;'" + newline
      pk = string % [str(db), str(db)]
    end
>>>>>>> Stashed changes
    pk
  end

  def drop_foreign_keys
    fk_text = ''
    self.foreign_keys.each do |fk|
      fk_text.concat(indent + ("execute 'ALTER TABLE \"%s\" DROP CONSTRAINT \"FK_%s_%s\";'#{newline}" % [self.ms_database_name, fk.target_td.database_name, self.database_name]))
    end
    fk_text
  end

  def drop_indexes
    in_text = ''
    self.foreign_keys.each do |fk|
      in_text.concat(indent + ("execute 'DROP \"INDEX IN_FK_%s_%s\";'#{newline}" % [fk.target_td.database_name, self.database_name]))
    end
    in_text
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
    function + create_table + db_columns + create_primary_key + create_foreign_keys + end_function
  end

  def end_function
    'end' + newline + newline
  end

  def create_migration_down
    function = 'def down' + newline
    drop_table = indent + 'drop_table :' + self.ms_database_name + newline
    function + drop_primary_key + drop_foreign_keys + drop_indexes + drop_table + end_function
  end

  def generate_migration
    up = create_migration_up
    down = create_migration_down
    up + down
  end
end

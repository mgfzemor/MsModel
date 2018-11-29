FactoryBot.define do
  factory :column do
    system_name { "MyString" }
    database_name { "MyString" }
    nn { false }
    uq { false }
    bin { false }
    un { false }
    zf { false }
    g { false }
    active_id { false }
    active_created { false }
    active_updated { false }
    msColumnType { nil }
    table { nil }
  end
end

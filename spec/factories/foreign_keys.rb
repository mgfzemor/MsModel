FactoryBot.define do
  factory :foreign_key do
    source_column { 1 }
    source_table { 1 }
    target_column { 1 }
    target_table { 1 }
  end
end

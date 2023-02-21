FactoryBot.define do
  factory :like do
    click { 1 }
    user { nil }
    likeable { nil }
  end
end

FactoryBot.define do
  factory :drone do
    title { "TitleDrone" }
    category

    trait :invalid do
      title { nil }
    end
  end
end

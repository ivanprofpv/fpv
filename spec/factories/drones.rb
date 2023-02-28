FactoryBot.define do
  factory :drone do
    title { "TitleDrone" }
    body { "BodyDrone" }
    category

    trait :invalid do
      title { nil }
    end
  end
end

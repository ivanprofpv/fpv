FactoryBot.define do
  factory :drone do
    title { "TitleDrone" }
    body { "BodyDrone" }

    trait :invalid do
      title { nil }
    end
  end
end

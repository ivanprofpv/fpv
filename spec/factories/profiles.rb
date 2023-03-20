FactoryBot.define do
  factory :profile do
    user { nil }
    name { "name" }
    about { "about" }
    city { "city" }

    trait :invalid do
      name { "12345678901234567890
              12345678901234567890
              123456789012345678901" }
    end
  end
end

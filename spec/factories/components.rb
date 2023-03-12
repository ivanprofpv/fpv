FactoryBot.define do
  factory :component do
    title { "MyString" }
    url { "https://ya.ru" }
    price { 1 }

    trait :invalid do
      title { nil }
      price { nil }
      url { "https//yaru" }
    end
  end
end

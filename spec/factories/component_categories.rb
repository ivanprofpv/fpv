FactoryBot.define do
  factory :component_category do
    title { 'title_category_component' }

    trait :invalid do
      title { nil }
    end
  end
end

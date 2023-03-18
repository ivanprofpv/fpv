FactoryBot.define do
  sequence :email do |n|
    "user#{n}@test.com"
  end
  sequence :username do |n|
    "user#{n}"
  end

  factory :user do
    username
    email
    password { '12345678' }
    password_confirmation { '12345678' }
    confirmed_at { Time.zone.now }
  end

  trait :unconfirmed do
    confirmed_at { nil }
  end
end

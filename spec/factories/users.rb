FactoryBot.define do
  factory :user do
    sequence(:username) { |n| "user#{n}" }
    sequence(:email) { |n| "user#{n}@user.com" }
    trait :role do
      association :role, factory: :role
    end
  end
end

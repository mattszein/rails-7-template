FactoryBot.define do
  factory :user do
    sequence(:username) { |n| "user#{n}" }
    sequence(:email) { |n| "user#{n}@user.com" }
    trait :role do
      association :role, factory: :role
    end
    trait :superadmin do
      association :role, factory: :role, id: 1
    end
  end
end

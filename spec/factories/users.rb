FactoryBot.define do
  factory :user do
    username { "User" }
    email { "user@user.com" }
    trait :role do
      association :role, factory: :role
    end
  end
end

FactoryBot.define do
  factory :permission do
    resource { "ApplicationPolicy" }
    role_ids { [create(:role).id] }
  end
end

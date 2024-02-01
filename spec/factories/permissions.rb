FactoryBot.define do
  factory :permission do
    resource { Adminit::ApplicationPolicy.identifier }
    role_ids { [create(:role).id] }
  end
end

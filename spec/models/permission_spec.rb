require "rails_helper"

RSpec.describe Permission, type: :model do
  subject {
    create(:permission)
  }

  describe "Validations" do
    it "is valid with valid attributes" do
      expect(subject).to be_valid
    end

    it "is not valid without a resource name" do
      subject.resource = nil
      expect(subject).to_not be_valid
    end

    it "is not valid without roles ids" do
      subject.role_ids = nil
      expect(subject).to_not be_valid
    end

    it "is not valid with empty role ids" do
      subject.role_ids = []
      expect(subject).to_not be_valid
    end

    it "is not valid with blank role ids" do
      subject.role_ids = [""]
      expect(subject).to_not be_valid
    end
  end

  describe "class methods" do
    it "has a default" do
      expect(subject.class.default).to be_valid
    end
  end
end

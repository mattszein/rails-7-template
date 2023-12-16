# frozen_string_literal: true

# spec/models/user_spec.rb

require "rails_helper"

RSpec.describe User, type: :model do
  subject {
    described_class.new(username: "User_1", email: "user@email.com")
  }

  describe "Associations" do
    it { expect(subject).to have_many(:passwordless_sessions) }
  end

  describe "Validations" do
    it "is valid with valid attributes" do
      expect(subject).to be_valid
    end

    it "is valid with uniq email" do
      expect(subject).to validate_uniqueness_of(:email).case_insensitive
    end

    it "is not valid without a email" do
      subject.email = nil
      expect(subject).to_not be_valid
    end
  end
end

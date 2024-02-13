# frozen_string_literal: true

# spec/models/user_spec.rb

require "rails_helper"

RSpec.describe User, type: :model do
  subject {
    create(:user)
  }

  describe "Associations" do
    it { expect(subject).to have_many(:passwordless_sessions) }
    it { expect(subject).to belong_to(:role).optional }
  end

  describe "Validations" do
    it "is valid with valid attributes" do
      expect(subject).to be_valid
    end

    it "is valid with uniq email" do
      expect(subject).to validate_uniqueness_of(:email).case_insensitive
    end

    it "is not valid without an email" do
      subject.email = nil
      expect(subject).to_not be_valid
    end

    it "is not valid with an invalid email" do
      subject.email = "invalid_email"
      expect(subject).to_not be_valid
    end

    it "is valid without a role" do
      subject.role = nil
      expect(subject).to be_valid
    end

    it "cannot access to adminit without a role" do
      expect(subject.adminit_access?).to be_falsey
    end

    describe "with role" do
      subject {
        create(:user, :role)
      }

      it "can access to adminit" do
        expect(subject.adminit_access?).to be_truthy
      end
    end
  end
end

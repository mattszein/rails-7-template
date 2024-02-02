# frozen_string_literal: true

require "rails_helper"
require Rails.root.join("spec", "controllers", "shared", "responds.rb")

describe Adminit::DashboardController, type: :controller do
  render_views

  describe "GET #index" do
    subject { get :index, params: {} }

    context "when not logged" do
      it_behaves_like "unauthenticated"
    end

    context "when logged" do
      context "without a role" do
        before do
          login_user(create(:user)) # login user
        end

        it_behaves_like "unauthorized"
      end

      context "with a role" do
        before do
          @user = create(:user, :role)
          login_user(@user) # login user
          create(:permission, role_ids: [@user.role_id])
        end

        it "is authorized" do
          expect { subject }.to be_authorized_to(:manage?, :index?).with(Adminit::DashboardPolicy).with_context(user: @user)
        end
        it_behaves_like "respond to success"
      end
    end
  end
end

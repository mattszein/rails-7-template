# frozen_string_literal: true

require "rails_helper"
require Rails.root.join("spec", "controllers", "shared", "responds.rb")

describe Adminit::PermissionsController, type: :controller do
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
        let!(:user) { create(:user, :role) }
        let!(:permission) { create(:permission, role_ids: [user.role_id]) }

        before do
          login_user(user) # login user
        end

        it "is authorized" do
          expect { subject }.to be_authorized_to(:manage?, Permission).with(Adminit::PermissionPolicy).with_context(user: user)
        end
        it_behaves_like "respond to success"
      end
    end
  end

  describe "PUT #update" do
    # Using `let` and `let!` for setup
    let!(:user) { create(:user, :role) }
    let(:role) { Role.create(name: "Role") }
    let(:permission) { create(:permission, role_ids: [user.role_id]) }
    let(:params_update) { {id: permission.id, permission: {role_ids: [user.role_id, role.id]}} }

    subject { put :update, params: params_update }

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
          login_user(user) # login user
        end

        it "is authorized" do
          expect { subject }.to be_authorized_to(:manage?, Permission).with(Adminit::PermissionPolicy).with_context(user: user)
        end

        it_behaves_like "respond with redirect"

        it "updates role_ids" do
          expect { subject }.to change { permission.reload.role_ids.length }.by(1)
        end

        it "redirects to adminit_permissions_path" do
          expect(subject).to redirect_to adminit_permissions_path
        end

        it "flashes a success message" do
          subject # call subject
          expect(flash[:notice]).not_to be_nil
        end

        context "when role_ids contains invalid id" do
          before do
            params_update[:permission][:role_ids] << 0
          end

          it "flashes an alert message" do
            subject # call subject
            expect(flash[:alert]).not_to be_nil
          end
          it "doesn't update role_ids" do
            expect { subject }.to change { permission.reload.role_ids.length }.by(0)
          end
        end
      end
    end
  end
end

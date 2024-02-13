# frozen_string_literal: true

require "rails_helper"
require Rails.root.join("spec", "controllers", "shared", "responds.rb")

describe Adminit::PermissionsController, type: :controller do
  include_context "user and permissions adminit"
  describe "GET #index" do
    subject { get :index, params: {} }

    include_context "auth"
    context "when logged" do
      context "with a role" do
        before do
          login_user(user) # login user
          permission
        end

        it "is authorized" do
          expect { subject }.to be_authorized_to(:manage?, Permission).with(Adminit::PermissionPolicy).with_context(user: user)
        end
        it_behaves_like "respond to success"
      end
    end
  end

  describe "PUT #update" do
    let(:role) { Role.create(name: "Role") }
    let(:params_update) { {id: permission.id, permission: {role_ids: [user.role_id, role.id]}} }

    subject { put :update, params: params_update }

    include_context "auth"
    context "when logged" do
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

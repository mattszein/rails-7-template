# frozen_string_literal: true

require "rails_helper"
require Rails.root.join("spec", "controllers", "shared", "responds.rb")

describe Adminit::RolesController, type: :controller do
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
          expect { subject }.to be_authorized_to(:manage?, Role).with(Adminit::RolePolicy).with_context(user: user)
        end
        it_behaves_like "respond to success"
      end
    end
  end

  describe "GET #user_select" do
    subject { get :user_select, params: {id: user.role.id} }

    include_context "auth"

    context "when logged" do
      context "with a role" do
        before do
          login_user(user) # login user
          permission
        end

        it "is authorized" do
          expect { subject }.to be_authorized_to(:manage?, Role).with(Adminit::RolePolicy).with_context(user: user)
        end
        it_behaves_like "respond to success"
      end
    end
  end

  describe "DELETE #remove_user" do
    include_context "user and permissions adminit"
    let(:params) { {id: user.role.id, user_id: user.id} }

    subject { delete :remove_user, params: params }

    include_context "auth"

    context "when logged" do
      context "with a role" do
        before do
          login_user(user) # login user
          permission
        end

        it "is authorized" do
          expect { subject }.to be_authorized_to(:remove_user?, user.role).with(Adminit::RolePolicy).with_context(user: user)
        end

        it "remove user from role with valid id" do
          expect { subject }.to change { user.reload.role_id }.from(user.role_id).to(nil)
        end

        it "flashes a success message" do
          subject # call subject
          expect(flash[:notice]).not_to be_nil
        end
      end

      context "with a superadmin role" do
        before do
          permission
        end

        it "can't remove user if role is superadmin and it's the only one" do
          expect { subject }.not_to change { user.reload.role_id }
        end
      end

      context "with two superadmin roles" do
        before do
          create(:user, role: user_superadmin.role)
          params = {id: user_superadmin.role.id, user_id: user_superadmin.id}
          permission.update(role_ids: [user_superadmin.role_id])
          login_user(user_superadmin) # login user
        end

        it "should remove user" do
          expect { subject }.to change { user.reload.role_id }
        end
      end
    end
  end

  describe "POST #add_user" do
    include_context "user and permissions adminit"
    let(:new_user) { create(:user) }
    let(:params) { {id: user.role.id, role: {email: new_user.email}} }

    subject { post :add_user, params: params }

    include_context "auth"

    context "when logged" do
      context "with proper permissions" do
        before do
          login_user(user_superadmin) # login superadmin user
          permission_superadmin
        end

        it "is authorized" do
          expect { subject }.to be_authorized_to(:manage?, user.role).with(Adminit::RolePolicy).with_context(user: user_superadmin)
        end

        it "add user to role" do
          expect { subject }.to change { user.role.users.count }.from(1).to(2)
        end

        it "flashes a success message" do
          subject # call subject
          expect(flash[:notice]).not_to be_nil
        end

        context "when user already has a role" do
          let(:params) { {id: user.role.id, role: {email: user.email}} }

          it "don't add user to role" do
            expect { subject }.not_to change { user.role.users.count }
          end

          it "flashes an alert message" do
            subject # call subject
            expect(flash[:alert]).not_to be_nil
          end
        end
      end
    end
  end
end

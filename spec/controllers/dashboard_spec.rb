# frozen_string_literal: true

require "rails_helper"
require Rails.root.join("spec", "controllers", "shared", "responds.rb")

describe DashboardController, type: :controller do
  render_views

  describe "GET #index" do
    subject { get :index, params: {} }

    context "when not logged" do
      it_behaves_like "respond with redirect"
    end

    context "when logged" do
      before do
        login_user(create(:user)) # login user
      end

      it_behaves_like "respond to success"
    end
  end
end

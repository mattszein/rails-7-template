# frozen_string_literal: true

require "rails_helper"
require "nokogiri"
require Rails.root.join("spec", "controllers", "shared", "responds.rb")

describe UsersController, type: :controller do
  render_views

  describe "GET #new" do
    subject { get :new, params: {} }

    context "when valid" do
      it_behaves_like "respond to success"
    end
  end

  describe "POST #create" do
    let(:params_create) { attributes_for(:user) }

    subject { post :create, params: {user: params_create} }

    context "when valid" do
      it "creates an item" do
        expect { subject }.to change(User, :count).by(1)
      end

      it_behaves_like "respond with redirect"

      it "redirect to token verification" do
        subject
        @session = Passwordless::Session.last
        expect(response).to redirect_to "/users/sign_in/#{@session.identifier}"
      end

      it "send an email with valid token" do
        expect { subject }.to change { ActionMailer::Base.deliveries.count }.by(1)
        # extract token from email
        doc = Nokogiri::HTML(ActionMailer::Base.deliveries.first.body.to_s)
        token = doc.at_css("[id=token]").text
        # check if token is valid
        expect(Passwordless::Session.last.authenticate(token)).to be true
      end
    end

    context "when invalid user param is submitted" do
      before { params_create[:email] = nil }

      it "don't create an item" do
        expect { subject }.to change(User, :count).by(0)
      end
    end
  end
end

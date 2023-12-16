# frozen_string_literal: true

require "system_helper"

describe "Sessions -> New" do
  it "I can fill email to login" do
    user = create(:user)
    visit users_sign_in_path
    fill_in "passwordless[email]", with: user.email
    click_button "Sign in"

    expect(page).to have_content "Enter code"
  end
end

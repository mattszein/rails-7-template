# frozen_string_literal: true

require "system_helper"

describe "Users -> New" do
  it "I can create a new user" do
    visit new_user_path

    fill_in "user[username]", with: "User_1"
    fill_in "user[email]", with: "user@user.com"
    check "user[terms_of_service]"
    click_button "Create"

    expect(page).to have_content "Enter code"
  end
end

# frozen_string_literal: true

require "system_helper"

describe "Sessions -> Show" do
  it "i can enter a valid token to login" do
    user = create(:user)
    session = Passwordless::Session.create(authenticatable: user)
    visit verify_users_sign_in_path(session.identifier)
    session.token.each_char.with_index(1) { |c, i| fill_in "code_#{i}", with: c }

    expect(page).to have_content "Hey"
  end
end

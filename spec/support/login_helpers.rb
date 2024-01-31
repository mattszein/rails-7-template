module LoginHelpers
  module Controller
    include Passwordless::ControllerHelpers
    def login_user(user)
      sign_in(Passwordless::Session.create!(authenticatable: user))
    end
  end
end

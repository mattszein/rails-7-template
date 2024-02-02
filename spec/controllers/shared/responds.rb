# frozen_string_literal: true

RSpec.shared_examples "respond to missing" do
  it "responds with 404" do
    expect(subject).to have_http_status(404)
  end
end

RSpec.shared_examples "respond to success" do
  it "should responds with success" do
    expect(subject).to have_http_status(200)
  end
end

RSpec.shared_examples "respond with redirect" do
  it "should responds with redirect" do
    expect(subject).to have_http_status(302)
  end
end

RSpec.shared_examples "respond to invalid params" do
  it "should responds with 422" do
    expect(subject).to have_http_status(422)
    assert_select "div#error_explanation", 1
  end
end

RSpec.shared_examples "unauthenticated" do
  it "should add a flash message" do
    expect { subject }.to change { flash[:alert] }.from(nil).to(I18n.t("authentication.unauthenticated"))
  end
  it "should responds with redirect" do
    expect(subject).to have_http_status(302)
  end
  it "redirects to sign_in" do
    expect(subject).to redirect_to users_sign_in_url
  end
end

RSpec.shared_examples "unauthorized" do
  it "should add a flash message" do
    expect { subject }.to change { flash[:alert] }.from(nil).to(I18n.t("adminit.authorization.unauthorized"))
  end
  it "should responds with redirect" do
    expect(subject).to have_http_status(302)
  end
  it "redirects to root_url" do
    expect(subject).to redirect_to root_url
  end
end

# frozen_string_literal: true

RSpec.shared_examples "respond to missing" do
  it "responds with 404" do
    expect(subject).to have_http_status(404)
  end
end

RSpec.shared_examples "respond to success" do
  it "should return room with success" do
    expect(subject).to have_http_status(200)
  end
end

RSpec.shared_examples "respond to invalid params" do
  it "should responds with 422" do
    expect(subject).to have_http_status(422)
    assert_select "div#error_explanation", 1
  end
end

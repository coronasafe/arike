require "rails_helper"

RSpec.describe "Users", type: :request do
  it "creates a new user with correct details" do
    full_name = Faker::Name.name
    email = Faker::Internet.email
    post create_custom_user_path, params: { user: { full_name: full_name, role: User.roles[:asha], email: email, phone: Faker::Number.number(digits: 10), verified: false, password: "0" } }
    user = User.last
    expect(user.full_name).to eq(full_name)
    expect(user.email).to eq(email)
  end

  it "validates new user email address" do
    full_name = Faker::Name.name
    email = "invalid_abcd$!@"
    post create_custom_user_path, params: { user: { full_name: full_name, role: User.roles[:asha], email: email, phone: Faker::Number.number(digits: 10), verified: false, password: "0" } }
    expect(User.count).to eq(0)
    expect(response).to redirect_to("/signup")
    follow_redirect!
    expect(response.body).to include("Email is invalid")
  end

  it "verify access of a unverified user without superuser privilidges" do
    user = FactoryBot.create(:user, verified: false)
    put "/users/:id/verify", params: { id: user.id }
    expect(User.find(user.id).verified).to eq(false)
    expect(response).to redirect_to("/")
  end
end

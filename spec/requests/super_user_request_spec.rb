require "rails_helper"

RSpec.describe "Super Users", type: :request do
  before :each do
    @superuser = FactoryBot.create(:user, role: User.roles[:superuser], verified: true)
    post "/sessions", params: { user: { login_id: @superuser.email, password: @superuser.password } }
  end

  it "verify access of a signed up user by super user" do
    user = FactoryBot.create(:user, verified: false)
    put "/users/#{user.id}/verify"
    expect(User.find_by_id(user.id).verified).to eq(true)
  end

  it "verify edit of user details by super user" do
    user = FactoryBot.create(:user, verified: true)

    # making a deep copy
    oldUser = Marshal.load(Marshal.dump(user))
    user.full_name = Faker::Name.name
    user.first_name = Faker::Name.first_name
    user.email = Faker::Internet.email
    user.phone = Faker::Number.number(digits: 10)
    put "/users/#{user.id}", params: { user: { first_name: user.first_name, full_name: user.full_name, role: user.role, email: user.email, phone: user.phone, verified: true } }
    finalUser = User.find_by_id(user.id)
    expect(finalUser.full_name).to eq(user.full_name)
    expect(finalUser.full_name).not_to eq(oldUser.full_name)
    expect(finalUser.first_name).to eq(user.first_name)
    expect(finalUser.first_name).not_to eq(oldUser.first_name)
    expect(finalUser.email).to eq(user.email)
    expect(finalUser.phone).not_to eq(oldUser.phone)
  end

  it "validates new user email address" do
    full_name = Faker::Name.name
    first_name = Faker::Name.first_name
    email = "invalid_abcd$!@"
    post "/users", params: { user: { first_name: first_name, full_name: full_name, role: User.roles[:asha], email: email, phone: Faker::Number.number(digits: 10), verified: false, password: "0" } }

    # Expecting the User.count = 1, since we have 1 Super User
    expect(User.count).to eq(1)
    expect(response).to redirect_to("/users/new")
    follow_redirect!
    expect(response.body).to include("Email is invalid")
  end
end

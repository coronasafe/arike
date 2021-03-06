after "development:superuser" do
  (1..20).each do |index|
    User.create!(
      first_name: Faker::Name.first_name,
      full_name: Faker::Name.name,
      role: User.roles.values.sample,
      password: "password",
      email: Faker::Internet.email,
      phone: rand(10 ** 10),
    )
  end
end

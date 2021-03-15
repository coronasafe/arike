class User < ApplicationRecord
  ROLES = %w(superuser primary_nurse secondary_nurse)

  validates :role, inclusion: {
                     in: ROLES,
                     message: "%{value} is not a valid role",
                   }

  def send_sms
    phone_num = ENV["TWILIO_SENDER_NUMBER"]
    puts "SMS sending stub"
    client = Twilio::REST::Client.new()
    to = "" # verified twilio number
    client.messages.create(
      from: phone_num,
      to: to,
      body: "Click here to login: ",
    )
  end
end

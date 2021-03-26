class User < ApplicationRecord
  has_secure_password
  has_one_time_password
  has_and_belongs_to_many :patients # how can user has many patients?
  belongs_to :facilities, optional: true
  enum roles: {
                superuser: "Superuser",
                primary_nurse: "Primary Nurse",
                secondary_nurse: "Secondary Nurse",
                asha: "ASHA",
                volunteer: "Volunteer",
              }
  SIGNUP_ROLES = [roles[:asha], roles[:volunteer]]
  validates :role, inclusion: {
                     in: roles.values,
                     message: "%{value} is not a valid role",
                   }
  scope :ashas, -> { where(role: roles[:asha]) }
  scope :volunteers, -> { where(role: roles[:volunteer]) }
  scope :primary_nurses, -> { where(role: roles[:primary_nurse]) }
  scope :secondary_nurses, -> { where(role: roles[:secondary_nurse]) }
  scope :nurses, -> { primary_nurses.or(secondary_nurses) }
  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password, presence: true, :on => :create
  validates :email, uniqueness: true
  validates :phone, uniqueness: true

  def send_sms(to, message)
    phone_num = ENV["TWILIO_SENDER_NUMBER"]
    client = Twilio::REST::Client.new()
    client.messages.create(
      from: phone_num,
      to: "+91" + to,
      body: message,
    )
  end

  def self.verified
    User.where(verified: true)
  end

  def self.unverified
    User.where(verified: false)
  end

  def superuser?
    self[:role] == User.roles[:superuser]
  end

  def has_facility_access?
    [User.roles[:superuser], User.roles[:primary_nurse], User.roles[:secondary_nurse]].include? self[:role]
  end
end

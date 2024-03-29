require "rails_helper"

RSpec.describe "Patient Treatments", type: :request do
  before :each do
    FactoryBot.create(:state)
    FactoryBot.create(:district)
    FactoryBot.create(:lsg_body)
    FactoryBot.create(:ward)
    FactoryBot.create(:facility, kind: 'CHC')
    FactoryBot.create(:patient)
    @superuser = FactoryBot.create(:user, role: User.roles[:superuser], verified: true)

    (1..5).each do |i|
      category = "category_#{i}"
      FactoryBot.create(:treatment, category: category)
    end
    post user_session_path, params: { user: { login_id: @superuser.email, password: @superuser.password } }
  end

  it "Add any number of treatments" do
    patient = Patient.last
    number = rand(1..5)
    treatments = {}
    Treatment.limit(number).each do |t|
      treatments[t.id] = {name: t.name, category: t.category}
    end
    post "/patients/#{patient.id}/treatment", params: { patient_id: patient.id, treatments: treatments }
    treatments = patient.patient_treatments
    expect(treatments.count).to eq(number)
  end

  it "Stop a treatment" do
    patient = Patient.last
    treatment = { Treatment.first.id => { "name" => Treatment.first.name, "category" => Treatment.first.category } }
    patient.add_treatments(treatment)
    put "/patients/#{patient.id}/treatment/stop_treatment", params: { patient_id: patient.id, treatment: PatientTreatment.first.id}
    stopped_treatment = patient.patient_treatments.where.not(stopped_at: nil)
    expect(stopped_treatment.count).to eq(1)
  end

  it "Adding invalid treatment" do
    treatment = FactoryBot.create(:treatment, name: "Treatment", category: "Category")
    patient = Patient.last
    post "/patients/#{patient.id}/treatment", params: { patient_id: patient.id, treatments: { treatment.id => { name: treatment.name, category: treatment.category } } }
    treatments = patient.patient_treatments
    expect(treatments.count).to eq(0)
  end

  it "Stopping a treatment not linked to a patient" do
    patient = Patient.last
    treatment = Treatment.last
    put "/patients/#{patient.id}/treatment/stop_treatment", params: { patient_id: patient.id, treatment: treatment.id}
    stopped_treatment = patient.patient_treatments.where.not(stopped_at: nil)
    expect(stopped_treatment.count).to eq(0)
  end
end

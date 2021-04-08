class PatientsController < ApplicationController
  before_action :set_patient, only: [:show, :edit, :update]

  # GET /patients/
  def index
  end

  # GET /patients/new
  def new
    @patient = Patient.new
    render "/patients/personal_details/form"
  end

  # POST /patients
  def create
    @patient = Patient.create(patient_params)
    volunteer = params[:patient].permit(:volunteer => {})
    volunteer_user_ids = volunteer[:volunteer].to_h.filter { |_key, value| value.to_i == 1 }.map { |key, _value| key }
    @patient.add_users(volunteer_user_ids)
    if !@patient.valid?
      flash[:error] = @patient.errors.full_messages.join(", ")
      redirect_to new_patient_path
      return
    end
    redirect_to patients_path
  end

  # GET /patients/:id
  def show
    @patient = Patient.find_by(id: params[:id])
  end

  # GET /patients/:id/edit
  def edit
    render "/patients/personal_details/form"
  end

  # PUT /patients/:id/
  def update
    @patient.update(patient_params)
    volunteer = params[:patient].permit(:volunteer => {})
    volunteer_user_ids = volunteer[:volunteer].to_h.filter { |_key, value| value.to_i == 1 }.map { |key, _value| key }
    @patient.update_users(volunteer_user_ids)
    if !@patient.valid?
      flash[:error] = @patient.errors.full_messages.join(", ")
      redirect_to edit_patient_path
      return
    end
    redirect_to patient_path
  end

  private

  def set_patient
    @patient = Patient.find(params[:id])
  end

  def patient_params
    params.require(:patient).permit(:full_name, :dob, :address, :route, :phone, :economic_status,
                                    :notes, :gender,
                                    :emergency_phone_no, :disease, :facility_id)
  end
end

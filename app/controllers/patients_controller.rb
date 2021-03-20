class PatientsController < ApplicationController
  before_action :set_patient, only: [:show, :edit, :update, :destroy]

  def index
  end

  def new
    @patient = Patient.new
  end

  def create
    puts "params are "
    puts params
    patient = Patient.create!(patient_params)
    volunteer = params[:patient].permit(:volunteer => {})
    volunteer_user_ids = volunteer[:volunteer].to_h.filter { |key, value| value.to_i == 1 }.map { |key, value| key }
    patient.add_users(volunteer_user_ids)
    redirect_to patients_path
  end

  def show
    @patient = Patient.find_by(id: params[:id])
  end

def edit
  end

  def update
    @patient.update!(patient_params)
    redirect_to patients_path
  end

  private

  def set_patient
    @patient = Patient.find(params[:id])
  end

  def patient_params
    params.require(:patient).permit(:full_name, :dob, :address, :route, :phone, :economic_status,
                                    :notes, :asha_member, :reported_by, :lsg_body)
  end
end

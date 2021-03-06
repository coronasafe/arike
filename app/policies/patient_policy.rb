class PatientPolicy < ApplicationPolicy
  def index?
    user && record
    (user.superuser? || user.medical_officer? || user.nurse?)
  end

  alias show? index?
  alias new? index?
  alias create? index?
  alias edit? index?
  alias update? index?
  alias show_detail? index?

  class Scope < Scope
    def resolve
      return Patient.all if (user.superuser?)

      # CHC -> All PHCs
      all_facilities =
        Facility
          .where(id: user.facility.id)
          .or(Facility.where(parent_id: user.facility.id))
return Patient.joins(:facility).where(facilities: all_facilities) if user.secondary_nurse? || user.medical_officer?
      end

      return user.facility.patients if user.primary_nurse?

      Patient.none
    end
  end
end

# Secondary Nurse or Medical Officer -> Join table for each facility and facility under it
#  Patient.joins(:facility).where(facilities: [user.facility.primary_facilities])

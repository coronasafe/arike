class UsersController < ApplicationController
  def index
    authorize User
  end

  def new
    @user = User.new
    authorize User
  end

  def edit
    @user = User.find(params[:id])
    authorize User
  end

  def update
    new_user =
      params
        .require(:user)
        .permit(:full_name, :role, :email, :phone)
    user = User.find(params[:id])
    authorize User
    if user
      user.update(
        full_name: new_user[:full_name],
        role: new_user[:role],
        email: new_user[:email],
        phone: new_user[:phone],
      )
    end
    redirect_to users_path
  end

  def create
    data =
      params
        .require(:user)
        .permit(
          :full_name,
          :role,
          :email,
          :password,
          :phone,
          :verified,
        )

    user = User.new(data)

    if user.save
      flash[:notice] =
        "Created user #{data[:full_name]} successfully with role #{data[:role]}"
    else
      flash[:alert] = user.errors.full_messages.to_sentence
    end

    redirect_back fallback_location: new_user_path
  end

  def assign_facility
    assignables = params.require(:facility).permit(:facility_id, :user_id)
    @facility = policy_scope(Facility).find(assignables[:facility_id])
    authorize @facility

    user =
      User.add_to_facility(assignables[:user_id], assignables[:facility_id])
    if user.save
      flash[:notice] =
        "Successfully assigned #{user.full_name} to this facility!"
      redirect_to show_facility_users_path(assignables[:facility_id])
    else
      flash[:alert] = user.errors.full_messages.to_sentence
      redirect_to show_facility_users_path(assignables[:facility_id])
    end
  end

  def unassign_facility
    assignables = params.require(:facility).permit(:facility_id, :nurse_id)
    @facility = policy_scope(Facility).find(assignables[:facility_id])
    authorize @facility

    user =
      User.remove_from_facility(
        assignables[:nurse_id],
        assignables[:facility_id],
      )
    if user.save
      flash[:notice] =
        "Successfully removed #{user.full_name} to this facility!"
      redirect_to show_facility_users_path(assignables[:facility_id])
    else
      flash[:alert] = user.errors.full_messages.to_sentence
      redirect_to show_facility_users_path(assignables[:facility_id])
    end
  end

  def verify
    user = User.find_by(id: params[:id])
    authorize User
    user.update(verified: true) if user
    redirect_to users_path
  end
end

class UsersController < ApplicationController
  # skip_before_action :ensure_logged_in, only: [:signup, :create]
  before_action :ensure_superuser, only: [:index, :new, :update, :verify]

  def index
  end

  def new
    @user = User.new
  end

  def signup
    if current_user
      redirect_to dashboard_path
    end
    @user = User.new
    @user[:verified] = false
  end

  def edit
    @user = User.find_by_id(params[:id])
  end

  def update
    newUser = params.require(:user).permit(:full_name, :first_name, :role, :email, :phone)
    user = User.find_by_id(params[:id])
    if user
      user.update(full_name: newUser[:full_name], first_name: newUser[:first_name], role: newUser[:role], email: newUser[:email], phone: newUser[:phone])
    end
    redirect_to users_path
  end

  def create
    user = params.require(:user).permit(:full_name, :first_name, :role, :email, :phone, :password, :verified)
    user[:verified] = false

    if !user[:password] || user[:password].strip.empty?
      user[:password] = "arike"
    end

    user = User.new(user)

    if user.valid?
      user.save
      redirect_to new_session_path, notice: "You have successfully signed up!"
    else
      flash[:error] = user.errors.full_messages.to_sentence
      redirect_to signup_path
    end
  end

  def assign_facility
    assignables = params.require(:facility).permit(:facility_id, :user_id)
    puts assignables

    user = User.add_to_facility(assignables[:user_id], assignables[:facility_id])
    if user.save
      flash[:success] = "Successfully assigned #{user.full_name} to this facility!"
      redirect_to facility_path(assignables[:facility_id])
    else
      flash[:error] = user.errors.full_messages.to_sentence
      redirect_to facility_path(assignables[:facility_id])
    end
  end

  def verify
    user = User.find_by_id(params[:id])
    if user
      user.update(verified: true)
    end
    redirect_to users_path
  end
end

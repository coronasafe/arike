class LsgBodiesController < ApplicationController
  before_action :set_lsg_body, only: %i[edit update]

  def index
    @lsg_body = LsgBody.all
    authorize LsgBody
  end

  def new
    @lsg_body = LsgBody.new
    authorize LsgBody
  end

  def create
    authorize LsgBody
    LsgBody.create(lsg_bodies_params)
    redirect_to lsg_bodies_path
  end

  def show
    id = params[:id]
    @lsg_body = LsgBody.find(id)
    authorize LsgBody
    @wards = Ward.where(lsg_body_id: id)
  end

  def edit
    authorize LsgBody
  end

  def update
    authorize LsgBody
    @lsg_body.update(lsg_bodies_params)
    redirect_to lsg_body_path(params[:id])
  end

  def destroy
    authorize LsgBody
    LsgBody.delete(params[:id])
    redirect_to lsg_bodies_path
  end

  private

  def set_lsg_body
    @lsg_body = LsgBody.find(params[:id])
  end

  def lsg_bodies_params
    params.require(:lsg_body).permit(:name, :kind, :code, :district_id)
  end
end

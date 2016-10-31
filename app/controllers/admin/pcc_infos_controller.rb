class Admin::PccInfosController < ApplicationController
  before_action :authenticate_admin!

  def index
    @pcc_infos = PccInfo.paginate(page: params[:page], per_page: 10)
  end

  def new
    @pcc_info = PccInfo.new
  end

  def create
    @pcc_info = Pcc.Info.new(pcc_info_params)
    if @pcc_info.save
      redirect_to admin_pcc_infos_path, notice: "New record was added."
    else
      render :new, alert: 'New record was not added.'
    end
  end

  def import_file
    PccInfo.import(params[:file])
    redirect_to admin_pcc_infos_path, notice: "Data imported!"
  end
end

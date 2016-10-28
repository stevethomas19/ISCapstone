class Admin::PccInfosController < ApplicationController
  before_action :authenticate_admin!

  def index
    #code
  end

  def import_file
    PccInfo.import(params[:file])
    redirect_to admin_pcc_infos_path, notice: "Data imported!"
  end
end

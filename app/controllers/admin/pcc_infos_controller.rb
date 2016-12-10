class Admin::PccInfosController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_pcc_info, only: [:edit, :update, :destroy]

  def index
    @pcc_infos = params[:query] ? PccInfo.order("tran_date DESC").search(params[:query]) : PccInfo.order("tran_date DESC")
    @pcc_infos = @pcc_infos.paginate(page: params[:page], per_page: 10)
  end

  def new
    @pcc_info = PccInfo.new
  end

  def create
    @pcc_info = PccInfo.new(pcc_info_params)
    if @pcc_info.save
      detector = GenderDetector.new(case_sensitive: false)
      PccInfo.predict_gender(@pcc_info, detector)
      redirect_to admin_pcc_infos_path, notice: "New record was added."
    else
      render :new, alert: 'New record was not added.'
    end
  end

  def edit
  end

  def update
    if @pcc_info.update(pcc_info_params)
      redirect_to admin_pcc_infos_path, notice: 'Record was modified.'
    else
      render :edit, alert: 'Record could not be modified'
    end
  end

  def destroy
    @pcc_info.destroy
    redirect_to admin_pcc_infos_path, notice: "Record has been removed."
  end

  def show
    redirect_to admin_pcc_infos_path
  end

  def import_file
    PccInfo.import(params[:file])
    redirect_to admin_pcc_infos_path, notice: "Data imported!"
  end

  private
  def set_pcc_info
    @pcc_info = PccInfo.find_by(id: params[:id])
  end

  def pcc_info_params
    params.require(:pcc_info).permit(:filed, :pcc, :tran_id, :tran_type, :tran_date, :tran_amt, :inkind, :loan, :amends, :name, :purpose,
                                     :address1, :address2, :city, :state, :zip, :inkind_comments)
  end
end

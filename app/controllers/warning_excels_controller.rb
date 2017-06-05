class WarningExcelsController < ApplicationController
  include SessionsHelper
  before_action :admin_login
  before_action :check_params, only: :create

  def create
    @warning_excel = WarningExcel.create(excel_params)
    flash="文件:#{@warning_excel.file_file_name} 已经成功上传"
    redirect_to warning_excels_path, flash: {success: flash}
  end

  def parse
    @warning_excel=WarningExcel.find_by(id: params[:id])
    workbook=Roo::Spreadsheet.open(@warning_excel.file.path)
    workbook.default_sheet = workbook.sheets[0]
    ((workbook.first_row + 1)..workbook.last_row).each do |row_index|
      warningdb=WarningDb.new
      warningdb.supplier=workbook.row(row_index)[1]
      warningdb.product_code=workbook.row(row_index)[2]
      warningdb.safe_num=workbook.row(row_index)[3]
      warningdb.common_num=workbook.row(row_index)[4]
      warningdb.save
    end
    @warning_excel.update_attribute(:parse, true)
    flash[:success]="Excel文件中的数据已解析"
    redirect_to warning_excels_path
  end

  def clean
    WarningDb.delete_all
    ActiveRecord::Base.connection.reset_pk_sequence!('warning_dbs')
    WarningExcel.all.each do |excel|
      excel.update_attribute(:parse, false)
    end
    redirect_to warning_excels_path, flash: {success: "库存数据已全部清空"}
  end

  def index
    @warning_excels=WarningExcel.paginate(:page => params[:excel_page], :per_page => 8).order('created_at DESC')
  end

  def destroy
    @warning_excel=WarningExcel.find_by(id: params[:id])
    flash="文件: #{@warning_excel.file_file_name} 已被成功删除"
    @warning_excel.destroy
    redirect_to warning_excels_path, flash: {success: flash}
  end

  private

  def check_params
    if params[:warning_excel].nil?
      flash="请选择要上传的文件"
      redirect_to repertory_excels_path, flash: {warning: flash}
    elsif !["application/vnd.ms-excel", "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet,", "application/octet-stream"]
               .include?(params[:warning_excel][:file].content_type)
      flash="请上传excel格式的文件(xlsx/xlsm/xls)"
      redirect_to warning_excels_path, flash: {danger: flash}
    end
  end

  def excel_params
    params.require(:warning_excel).permit(:file)
  end

  def admin_login
    admin?(current_user)
  end


end

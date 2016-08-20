class StockExcelsController < ApplicationController

  include SessionsHelper
  before_action :admin_login
  before_action :check_params, only: :create

  def create
    @stock_excel = StockExcel.create(excel_params)
    workbook=Roo::Spreadsheet.open(@stock_excel.file.path)
    workbook.default_sheet = workbook.sheets[0]

    StockDb.delete_all

    ((workbook.first_row + 1)..workbook.last_row).each do |row_index|
      stockdb=StockDb.new
      stockdb.product=workbook.row(row_index)[1]
      stockdb.import_company=workbook.row(row_index)[2]
      stockdb.export_num=workbook.row(row_index)[3]
      stockdb.export_company=workbook.row(row_index)[4]
      stockdb.export_num=workbook.row(row_index)[5]
      stockdb.save
    end

    flash="文件:#{@stock_excel.file_file_name} 已经成功上传"
    redirect_to stock_excels_path, flash: {success: flash}
  end

  def index
    @stock_excels=StockExcel.paginate(:page => params[:stock_page], :per_page => 8).order('created_at DESC')
    @stock_excel=StockExcel.new
    @new_users=User.new_users(true)
    @users=User.new_users(false)
  end

  def destroy
    @stock_excel=StockExcel.find_by(id: params[:id])
    flash="文件: #{@stock_excel.file_file_name} 已被成功删除"
    @stock_excel.destroy
    redirect_to stock_excels_path, flash: {success: flash}
  end

  def check_params
    if params[:stock_excel].nil?
      flash="请选择要上传的文件"
      redirect_to stock_excels_path, flash: {warning: flash}
    elsif !["application/vnd.ms-excel", "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet","application/octet-stream"]
               .include?(params[:stock_excel][:file].content_type)
      flash="请上传excel格式的文件(xlsx/xlsm)"
      redirect_to stock_excels_path, flash: {danger: flash}
    end
  end


  private

  def excel_params
    params.require(:stock_excel).permit(:file)
  end

  def admin_login
    admin?(current_user)
  end

end



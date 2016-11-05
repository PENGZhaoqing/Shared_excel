class StockExcelsController < ApplicationController

  include SessionsHelper
  before_action :admin_login
  before_action :check_params, only: :create

  def create
    @stock_excel = StockExcel.create(excel_params)
    flash="文件:#{@stock_excel.file_file_name} 已经成功上传"
    redirect_to stock_excels_path, flash: {success: flash}
  end

  def index
    @stock_excels=StockExcel.paginate(:page => params[:stock_page], :per_page => 8).order('created_at DESC')
  end

  def clean
    StockDb.delete_all
    ActiveRecord::Base.connection.reset_pk_sequence!('stock_dbs')
    StockExcel.all.each do |excel|
      excel.update_attribute(:parse, false)
    end
    redirect_to stock_excels_path, flash: {success: "出库数据已全部清空"}
  end

  def parse
    @stock_excel=StockExcel.find_by(id: params[:id])
    workbook=Roo::Spreadsheet.open(@stock_excel.file.path)
    workbook.default_sheet = workbook.sheets[0]

    ((workbook.first_row + 1)..workbook.last_row).each do |row_index|
      stockdb=StockDb.new
      stockdb.complete_time=workbook.row(row_index)[10]
      stockdb.supplier=workbook.row(row_index)[12]
      stockdb.client_name=workbook.row(row_index)[13]
      stockdb.product_code=workbook.row(row_index)[18]
      stockdb.product_name=workbook.row(row_index)[19]
      stockdb.standard=workbook.row(row_index)[20]
      stockdb.kind=workbook.row(row_index)[33]
      stockdb.export_num=workbook.row(row_index)[34]
      stockdb.project_code=workbook.row(row_index)[40]
      stockdb.bill_name=workbook.row(row_index)[5]
      stockdb.save
    end
    @stock_excel.update_attribute(:parse, true)
    redirect_to stock_excels_path, flash: {success: "Excel文件中的数据已成功解析"}
  end

  def destroy
    @stock_excel=StockExcel.find_by(id: params[:id])
    flash="文件: #{@stock_excel.file_file_name} 已被成功删除"
    @stock_excel.destroy
    redirect_to stock_excels_path, flash: {success: flash}
  end

  private


  def check_params
    if params[:stock_excel].nil?
      flash="请选择要上传的文件"
      redirect_to stock_excels_path, flash: {warning: flash}
    elsif !["application/vnd.ms-excel", "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet", "application/octet-stream"]
               .include?(params[:stock_excel][:file].content_type)
      flash="请上传excel格式的文件(xlsx/xlsm)"
      redirect_to stock_excels_path, flash: {danger: flash}
    end
  end

  def excel_params
    params.require(:stock_excel).permit(:file)
  end

  def admin_login
    admin?(current_user)
  end

end



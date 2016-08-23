class SupplierExcelsController < ApplicationController

  include SessionsHelper
  before_action :admin_login
  before_action :check_params, only: :create

  def create
    @supplier_excel = SupplierExcel.create(excel_params)
    flash="文件:#{@supplier_excel.file_file_name} 已经成功上传"
    redirect_to supplier_excels_path, flash: {success: flash}
  end

  def parse
    @supplier_excel=SupplierExcel.find_by(id: params[:id])
    workbook=Roo::Spreadsheet.open(@supplier_excel.file.path)
    workbook.default_sheet = workbook.sheets[0]
    ((workbook.first_row + 1)..workbook.last_row).each do |row_index|
      supplierdb=SupplierDb.new
      supplierdb.product=workbook.row(row_index)[1]
      supplierdb.supplier=workbook.row(row_index)[2]
      supplierdb.save
    end
    redirect_to supplier_excels_path, flash: {success: "Excel文件中的数据已解析"}
  end

  def clean
    SupplierDb.delete_all
    redirect_to supplier_excels_path, flash: {success: "遴选数据已清空"}
  end

  def index
    @supplier_excels=SupplierExcel.paginate(:page => params[:excel_page], :per_page => 8).order('created_at DESC')
  end

  def destroy
    @supplier_excel=SupplierExcel.find_by(id: params[:id])
    flash="文件: #{@supplier_excel.file_file_name} 已被成功删除"
    @supplier_excel.destroy
    redirect_to supplier_excels_path, flash: {success: flash}
  end

  private

  def check_params
    if params[:supplier_excel].nil?
      flash="请选择要上传的文件"
      redirect_to supplier_excels_path, flash: {warning: flash}
    elsif !["application/vnd.ms-excel", "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet", "application/octet-stream"]
               .include?(params[:supplier_excel][:file].content_type)
      flash="请上传excel格式的文件(xlsx/xlsm)"
      redirect_to supplier_excels_path, flash: {danger: flash}
    end
  end

  def excel_params
    params.require(:supplier_excel).permit(:file)
  end

  def admin_login
    admin?(current_user)
  end

end



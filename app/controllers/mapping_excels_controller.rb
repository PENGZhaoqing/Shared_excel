class MappingExcelsController < ApplicationController

  before_action :admin_login
  before_action :check_params, only: :create

  def create
    @mapping_excel = MappingExcel.create(excel_params)
    flash="文件:#{@mapping_excel.file_file_name} 已经成功上传"
    redirect_to mapping_excels_path, flash: {success: flash}
  end

  def parse
    @mapping_excel=MappingExcel.find_by(id: params[:id])
    workbook=Roo::Spreadsheet.open(@mapping_excel.file.path)
    workbook.default_sheet = workbook.sheets[0]
    ((workbook.first_row + 1)..workbook.last_row).each do |row_index|
      supplier1=workbook.row(row_index)[0]
      supplier2=workbook.row(row_index)[1]
      auth_token=MappingDb.new_token
      MappingDb.create!(supplier1: supplier1, supplier2: supplier2, auth_token: auth_token)
    end
    redirect_to mapping_excels_path, flash: {success: "Excel文件中的数据已解析"}
  end

  def clean
    MappingDb.delete_all
    redirect_to mapping_excels_path, flash: {success: "映射数据已清空"}
  end

  def index
    @mapping_excels=MappingExcel.paginate(:page => params[:excel_page], :per_page => 8).order('created_at DESC')
  end

  def destroy
    @mapping_excel=MappingExcel.find_by(id: params[:id])
    flash="文件: #{@mapping_excel.file_file_name} 已被成功删除"
    @mapping_excel.destroy
    redirect_to mapping_excels_path, flash: {success: flash}
  end

  private

  def check_params
    if params[:mapping_excel].nil?
      flash="请选择要上传的文件"
      redirect_to mapping_excels_path, flash: {warning: flash}
    elsif !["application/vnd.ms-excel", "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet", "application/octet-stream"]
               .include?(params[:mapping_excel][:file].content_type)
      flash="请上传excel格式的文件(xlsx/xlsm)"
      redirect_to mapping_excels_path, flash: {danger: flash}
    end
  end

  def excel_params
    params.require(:mapping_excel).permit(:file)
  end

  def admin_login
    admin?(current_user)
  end

end



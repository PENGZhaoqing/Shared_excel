class ProjectExcelsController < ApplicationController

  include SessionsHelper
  before_action :admin_login
  before_action :check_params, only: :create

  def create
    @project_excel = ProjectExcel.create(excel_params)
    flash="文件:#{@project_excel.file_file_name} 已经成功上传"
    redirect_to project_excels_path, flash: {success: flash}
  end

  def clean
    ProjectDb.delete_all
    ProjectExcel.all.each do |excel|
      excel.update_attribute(:parse, false)
    end
    redirect_to project_excels_path, flash: {success: "立项数据已全部清空"}
  end

  def parse
    @project_excel=ProjectExcel.find_by(id: params[:id])
    workbook=Roo::Excelx.new(@project_excel.file.path)
    workbook.default_sheet = workbook.sheets[0]

    ((workbook.first_row + 4)..workbook.last_row).each do |row_index|
      projectdb=ProjectDb.new
      projectdb.company=workbook.row(row_index)[1]
      projectdb.build_way=workbook.row(row_index)[2]
      projectdb.project_name=workbook.row(row_index)[3]
      projectdb.approve_time=workbook.row(row_index)[5]
      projectdb.save
    end

    @project_excel.update_attribute(:parse, true)
    redirect_to project_excels_path, flash: {success: "Excel文件中的数据已成功解析"}
  end

  def index
    @project_excels=ProjectExcel.paginate(:page => params[:excel_page], :per_page => 8).order('created_at DESC')
  end

  def destroy
    @project_excel=ProjectExcel.find_by(id: params[:id])
    flash="文件: #{@project_excel.file_file_name} 已被成功删除"
    @project_excel.destroy
    redirect_to project_excels_path, flash: {success: flash}
  end

  private

  def check_params
    if params[:project_excel].nil?
      flash="请选择要上传的文件"
      redirect_to project_excels_path, flash: {warning: flash}
    elsif !["application/vnd.ms-excel", "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet", "application/octet-stream"]
               .include?(params[:project_excel][:file].content_type)
      flash="请上传excel格式的文件(xlsx/xlsm/xls)"
      redirect_to project_excels_path, flash: {danger: flash}
    end
  end

# Use strong_parameters for attribute whitelisting
# Be sure to update your create() and update() controller methods.

  def excel_params
    params.require(:project_excel).permit(:file)
  end

  def admin_login
    admin?(current_user)
  end

end

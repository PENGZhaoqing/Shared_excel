require 'roo'

class ProjectExcelsController < ApplicationController

  before_action :check_params,only:  :create

  def create
    @project_excel = ProjectExcel.create(excel_params)
    workbook=Roo::Excelx.new(@project_excel.file.path)
    workbook.default_sheet = workbook.sheets[0]

    ProjectDb.delete_all

    ((workbook.first_row + 4)..workbook.last_row).each do |row_index|
      projectdb=ProjectDb.new
      projectdb.company=workbook.row(row_index)[1]
      projectdb.build_way=workbook.row(row_index)[2]
      projectdb.project_name=workbook.row(row_index)[3]
      projectdb.code=workbook.row(row_index)[4]
      projectdb.approve_time=workbook.row(row_index)[5]
      projectdb.begin_at=workbook.row(row_index)[7]
      projectdb.end_at=workbook.row(row_index)[8]
      projectdb.save
    end

    flash="文件:#{@project_excel.file_file_name} 已经成功上传"
    redirect_to project_excels_path, flash: {success: flash}

  end

  def index
    @project_excels=ProjectExcel.paginate(:page => params[:excel_page], :per_page => 8).order('created_at DESC')
    @project_dbs=ProjectDb.paginate(:page => params[:repertory_page], :per_page => 6)
    @project_excel=ProjectExcel.new
  end

  def destroy
    @project_excel=ProjectExcel.find_by(id: params[:id])
    flash="文件: #{@project_excel.file_file_name} 已被成功删除"
    @project_excel.destroy
    redirect_to project_excels_path, flash: {success: flash}
  end

  def check_params
    if params[:project_excel].nil?
      flash="请选择要上传的文件"
      redirect_to project_excels_path, flash: {warning: flash}
    elsif !["application/vnd.ms-excel", "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet","application/octet-stream"]
               .include?(params[:project_excel][:file].content_type)
      flash="请上传excel格式的文件(xlsx/xlsm/xls)"
      redirect_to project_excels_path, flash: {danger: flash}
    end
  end

  private

# Use strong_parameters for attribute whitelisting
# Be sure to update your create() and update() controller methods.

  def excel_params
    params.require(:project_excel).permit(:file)
  end


end

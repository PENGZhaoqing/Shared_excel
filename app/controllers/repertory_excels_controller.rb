class RepertoryExcelsController < ApplicationController

  before_action :check_params, only: :create

  def create
    @repertory_excel = RepertoryExcel.create(excel_params)
    workbook=Roo::Spreadsheet.open(@repertory_excel.file.path)

    workbook.default_sheet = workbook.sheets[0]


    RepertoryDb.delete_all

    ((workbook.first_row + 1)..workbook.last_row).each do |row_index|
      repertorydb=RepertoryDb.new
      repertorydb.name=workbook.row(row_index)[1]
      repertorydb.standard=workbook.row(row_index)[2]
      repertorydb.kind=workbook.row(row_index)[3]
      repertorydb.num=workbook.row(row_index)[5]
      repertorydb.supplier=workbook.row(row_index)[7]
      repertorydb.save
    end

    flash="文件:#{@repertory_excel.file_file_name} 已经成功上传"
    redirect_to repertory_excels_path, flash: {success: flash}
  end

  def index
    @repertory_excels=RepertoryExcel.paginate(:page => params[:excel_page], :per_page => 8).order('created_at DESC')
    @repertory_dbs=RepertoryDb.paginate(:page => params[:repertory_page], :per_page => 6)
    @repertory_excel=RepertoryExcel.new
  end

  def destroy
    @repertory_excel=RepertoryExcel.find_by(id: params[:id])
    flash="文件: #{@repertory_excel.file_file_name} 已被成功删除"
    @repertory_excel.destroy
    redirect_to repertory_excels_path, flash: {success: flash}
  end

  def check_params
    if params[:repertory_excel].nil?
      flash="请选择要上传的文件"
      redirect_to repertory_excels_path, flash: {warning: flash}
    elsif !["application/vnd.ms-excel", "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet,","application/octet-stream"]
               .include?(params[:repertory_excel][:file].content_type)
      flash="请上传excel格式的文件(xlsx/xlsm/xls)"
      redirect_to repertory_excels_path, flash: {danger: flash}
    end
  end


  private

  def excel_params
    params.require(:repertory_excel).permit(:file)
  end

end

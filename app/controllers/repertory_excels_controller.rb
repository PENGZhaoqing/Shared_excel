class RepertoryExcelsController < ApplicationController

  include SessionsHelper
  before_action :admin_login
  before_action :check_params, only: :create

  def create
    @repertory_excel = RepertoryExcel.create(excel_params)
    flash="文件:#{@repertory_excel.file_file_name} 已经成功上传"
    redirect_to repertory_excels_path, flash: {success: flash}
  end

  def parse
    @repertory_excel=RepertoryExcel.find_by(id: params[:id])
    workbook=Roo::Spreadsheet.open(@repertory_excel.file.path)
    workbook.default_sheet = workbook.sheets[0]

    ((workbook.first_row + 1)..workbook.last_row).each do |row_index|

      product_kind=workbook.row(row_index)[20]

      if product_kind=="VMI物资"

        name=workbook.row(row_index)[1]
        standard=workbook.row(row_index)[2]
        num=workbook.row(row_index)[5]
        supplier=workbook.row(row_index)[7]
        product_code=workbook.row(row_index)[11]
        if @repertory_db=RepertoryDb.find_by(supplier: supplier, product_code: product_code, product_kind: product_kind)
          @repertory_db.update_attribute(:num, @repertory_db.num+num)
        else
          RepertoryDb.create!(name: name, standard: standard, num: num, supplier: supplier, product_kind: product_kind, product_code: product_code)
        end

      end
    end

    @repertory_excel.update_attribute(:parse, true)
    redirect_to repertory_excels_path, flash: {success: "Excel文件数据解析成功"}
  end

  def clean
    RepertoryDb.delete_all
    ActiveRecord::Base.connection.reset_pk_sequence!('repertory_dbs')
    RepertoryExcel.all.each do |excel|
      excel.update_attribute(:parse, false)
    end
    redirect_to repertory_excels_path, flash: {success: "库存数据已全部清空"}
  end

  def index
    @repertory_excels=RepertoryExcel.paginate(:page => params[:excel_page], :per_page => 8).order('created_at DESC')
  end

  def destroy
    @repertory_excel=RepertoryExcel.find_by(id: params[:id])
    flash="文件: #{@repertory_excel.file_file_name} 已被成功删除"
    @repertory_excel.destroy
    redirect_to repertory_excels_path, flash: {success: flash}
  end

  private

  def check_params
    if params[:repertory_excel].nil?
      flash="请选择要上传的文件"
      redirect_to repertory_excels_path, flash: {warning: flash}
    elsif !["application/vnd.ms-excel", "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet,", "application/octet-stream"]
               .include?(params[:repertory_excel][:file].content_type)
      flash="请上传excel格式的文件(xlsx/xlsm/xls)"
      redirect_to repertory_excels_path, flash: {danger: flash}
    end
  end

  def excel_params
    params.require(:repertory_excel).permit(:file)
  end

  def admin_login
    admin?(current_user)
  end

end

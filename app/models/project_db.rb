class ProjectDb < ActiveRecord::Base

  def self.search(params)
    where('project_dbs.company LIKE ?', "%#{params[:company]}%")
        .where('project_dbs.build_way LIKE ?', "%#{params[:build_way]}%")
        .where('project_dbs.project_name LIKE ?', "%#{params[:project_name]}%")
        .where('project_dbs.approve_time LIKE ?', "%#{params[:approve_time]}%")
  end

end

class ChangeProjectUrlToProject < ActiveRecord::Migration
  def change
    rename_column :projects, :project_url, :url
  end
end

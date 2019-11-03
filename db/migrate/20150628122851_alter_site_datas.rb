class AlterSiteDatas < ActiveRecord::Migration
  def change
    add_column :site_datas, :site_url, :string, null:false, limit: 255
  end
end

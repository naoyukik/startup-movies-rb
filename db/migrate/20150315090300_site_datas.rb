class SiteDatas < ActiveRecord::Migration
  def up
    create_table :site_datas do |t|
      t.string :site_name, :null=>false
      t.integer :provider, :comment=>'1:youtube', :null=>false
      t.string :movie_url, :null=>false
      t.timestamps :null=>false
      t.index [:provider, :movie_url], :unique=>true, :name=>'unique_movie'
    end
  end
end

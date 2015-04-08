# coding: utf-8

require 'date'
require 'yaml'

require 'sinatra'
configure :development do |config|
  require "sinatra/reloader"
  config.also_reload "./*.rb"
end
require 'active_record'
require 'pg'
require 'will_paginate'
require 'will_paginate/active_record'

require './common-helper.rb'
require './lib-scrape.rb'
require './lib-youtube.rb'
require './controllers'
require './models'

set :public_folder, File.dirname(__FILE__) + '/stat'

# TODO: Check Currnet User Connected host address.
ActiveRecord::Base.configurations = YAML.load_file('./config/database.yaml')
ActiveRecord::Base.establish_connection(:development)

class SiteData < ActiveRecord::Base
  self.table_name = 'site_datas'
  self.per_page = 10
end

before do

end

after do

end

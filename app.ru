# coding: utf-8

require 'yaml'
require 'sinatra'
require 'sinatra/reloader'
require 'active_record'
require 'pg'

require './app/controllers/todo'

set :public_folder, File.dirname(__FILE__) + '/stat'

# database_config = YAML.load_file('./config/database.yaml')
# db_conf = database_config['development']
# CLIENT = Mysql2::Client.new(database_config['development'])

ActiveRecord::Base.configurations = YAML.load_file('./config/database.yaml')
ActiveRecord::Base.establish_connection(:development)

class Category < ActiveRecord::Base
  has_many :user_tasks
end

class UserTask < ActiveRecord::Base
  belongs_to :category
end

before do

end

after do

end

get '/' do

end

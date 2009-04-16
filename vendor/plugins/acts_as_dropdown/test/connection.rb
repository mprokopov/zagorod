print "Using native MySQL\n"
require 'logger'

ActiveRecord::Base.logger = Logger.new("debug.log")

db = 'acts_as_dropdown_plugin_test'

ActiveRecord::Base.establish_connection(
  :adapter  => "mysql",
  :host     => "localhost",
  :username => "root",
  :password => "",
  :database => db,
  :socket => "/var/run/mysqld/mysqld.sock"
)

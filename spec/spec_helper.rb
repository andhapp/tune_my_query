#%w(activerecord active_support yaml spec).each{|path| require path }

require "bundler"
Bundler.setup

require 'active_record'
require File.expand_path('../../lib/tune_my_query', __FILE__)
require File.expand_path('../models', __FILE__)

def connect(adapter)
  fix_quote_ident_postgres_error if adapter == "postgres"
  conf = YAML::load(File.open(File.dirname(__FILE__) + '/database.yml'))
  ActiveRecord::Base.establish_connection(conf[adapter])
  load(File.join(File.dirname(__FILE__), "schema.db"))
end

def fix_quote_ident_postgres_error
  require "pg"
  def PGconn.quote_ident(name); %("#{name}") end
end

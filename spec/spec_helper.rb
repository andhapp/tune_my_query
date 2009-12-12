require File.join(File.dirname(__FILE__), "..", "lib", "tune_my_query")

%w(activerecord active_support yaml spec).each{|path| require path }

%w(../init models).each{|path| require File.join(File.dirname(__FILE__), path) }
  
def connect(adapter)
  fix_quote_ident_postgres_error if adapter == "postgres"
  conf = YAML::load(File.open(File.dirname(__FILE__) + '/database.yml'))
  ActiveRecord::Base.establish_connection(conf[adapter])
  load(File.join(File.dirname(__FILE__), "schema.db"))
end

def fix_quote_ident_postgres_error
  require "postgres"
  def PGconn.quote_ident(name); %("#{name}") end
end